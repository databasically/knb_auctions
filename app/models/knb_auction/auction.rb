# t.integer  "reserve"
# t.datetime "start_at"
# t.datetime "end_at"
# t.integer  "product_id"
# t.integer  "created_by_id"
# t.datetime "created_at",    :null => false
# t.datetime "updated_at",    :null => false


module KnbAuction
  class Auction < ActiveRecord::Base
    attr_accessible :product_id, :product, :created_by_id, :end_at, :start_at, :reserve, :winner_notified_at
    attr_accessor :status, :highest_bidder, :duration
    
    belongs_to :product
    has_many :bids
    accepts_nested_attributes_for :bids, allow_destroy: true
    
    validates_presence_of :product_id
    validates_presence_of :start_at
    validates_presence_of :end_at
    
    after_initialize :initialize_working_variables
    after_save :enqueue_auction_close
    
    DURATION_WHITELIST = [['1 Day', 1.day.to_i], ['1 Week', 1.week.to_i], ['2 Weeks', 2.weeks.to_i], ['3 Weeks', 3.weeks.to_i], ['1 Month', 1.month.to_i]]
    TempBid = Struct.new(:owner, :goodles, :owner_name)
    TempOwner = Struct.new(:full_name, :goodles)
    
    
    def enqueue_auction_close
      # self.delay(:run_at => end_at, :queue => 'auction').close_auction
      delay(:run_at => 30.seconds.from_now, :queue => 'auction').close_auction
    end
    
    def close_auction
      # return unless auction_current
      delay.deduct_goodles
      delay.send_guardian_email(:run_at => 1.minute.from_now)
      delay.send_admin_email(:run_at => 1.minute.from_now)
    end
    
    def auction_current
      updated_at == Auction.find(:id).updated_at
    end
    
    def deduct_goodles
      "Did it!"
    end
    
    def send_guardian_email
      "Hello!"
    end
    
    def send_admin_email
      "Hello!"
    end
    
    def initialize_working_variables
      if start_at && end_at
        @status = auction_state_by_datetime
        @duration = (end_at - start_at).to_i
      end
    end
    
    def self.new_for_auction(auction_params = {})
      Auction.new(Auction.adjusted_parameters(auction_params))
    end
    
    def update_attributes_for_auction(auction_params = {})
      self.update_attributes(Auction.adjusted_parameters(auction_params))
    end
    
    def self.adjusted_parameters(auction_params)
      defaults = {end_at: duration_to_end_at(auction_params)}
      auction_params.delete(:duration)

      auction_params.reverse_merge(defaults)
    end

    def self.active
      where("start_at <= :now AND end_at >= :now", now: Time.now ).order('start_at asc')
    end
    
    def active?
      time_now = DateTime.now
      (start_at <= time_now) && (end_at >= time_now)
    end

    def self.closed
      where("end_at <= :now", now: Time.now ).order('start_at asc')
    end
    
    def closed?
      now = DateTime.now
      end_at < now
    end

    def self.upcoming
      where("start_at >= :now", now: Time.now ).order('start_at asc')
    end
    
    def upcoming?
      now = DateTime.now
      start_at > now
    end
    
    def self.bid_liability(child)
      find_by_highest_bidder(child).inject(0) { |goodles, auction|  goodles += auction.high_bid.goodles}
    end
    
    def duration
      return nil if end_at.nil? || start_at.nil?
      end_at - start_at
    end
    
    def self.goodles_to_spend(child)
      return 0 unless child.goodles
      goodles_liquid = child.goodles - Auction.bid_liability(child)
      return 0 if goodles_liquid <= 0
      goodles_liquid.to_i
    end
    
    def self.find_by_highest_bidder(child)
      self.all.select do |auction|
        if auction.high_bidder == child
          auction
        else
          next
        end
      end
    end
    
    def product_name
      product.name
    end
    
    def product_description
      if product.description
        product.description
      else
        ""
      end
    end
    
    def bids_count
      bids.size
    end
    
    def high_bid
      @high_bid ||= (bids.sort_by(&:goodles).last || empty_bid)
    end
    
    def high_bid_goodles
      high_bid.goodles
    end
    
    def empty_bid
      temp_bid
    end
    
    def temp_bid
      TempBid.new(temp_owner, reserve.to_i, "")
    end
    
    def temp_owner
      TempOwner.new("", 0)
    end
    
    def high_bidder
      high_bid.owner
    end
    
    def auction_state_by_datetime
      case
      when self.active?
        :active
      when self.upcoming?
        :upcoming
      when self.closed?
        :closed
      else
        :unknown
      end
    end
    
    def self.duration_to_end_at(auction_params)
      DateTime.parse(auction_params[:start_at]) + auction_params[:duration].to_i.seconds
    end
  end
end
