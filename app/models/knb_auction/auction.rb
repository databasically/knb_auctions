# t.integer  "reserve"
# t.datetime "start_at"
# t.datetime "end_at"
# t.integer  "product_id"
# t.integer  "created_by_id"
# t.datetime "created_at",    :null => false
# t.datetime "updated_at",    :null => false


module KnbAuction
  class Auction < ActiveRecord::Base
    belongs_to :product
    has_many :bids

    accepts_nested_attributes_for :bids, allow_destroy: true
    attr_accessible :product_id, :created_by_id, :end_at, :start_at, :reserve
    attr_accessor :status, :highest_bidder

    validates_presence_of :product
    validates_presence_of :start_at
    validates_presence_of :end_at
    
    DURATION_WHITELIST = [['1 Day', 1.day.to_i], ['1 Week', 1.week.to_i], ['2 Weeks', 2.weeks.to_i], ['3 Weeks', 3.weeks.to_i], ['1 Month', 1.month.to_i]]
    
    after_initialize :initialize_working_variables
    
    def initialize_working_variables
      if start_at && end_at
        @status = auction_state_by_datetime
      end
    end
    
    def self.new_for_auction(auction_params = {})
      Auction.new(Auction.adjusted_parameters(auction_params))
    end
    
    def update_attributes_for_auction(auction_params = {})
      self.update_attributes(Auction.adjusted_parameters(auction_params))
    end
    
    def self.adjusted_parameters(auction_params)
      defaults = {end_at: duration_to_end_at(auction_params), start_at: dateselect_parse(auction_params)}
      %w(duration start_at(1i) start_at(2i) start_at(3i) start_at(4i) start_at(5i)).each do |key|
        auction_params.delete(key)
      end
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
    
    def self.bid_liability(user)
      find_by_highest_bidder(user).inject(0) { |goodles, auction|  goodles += auction.high_bid.goodles}
    end
    
    def duration
      return nil if end_at.nil? || start_at.nil?
      end_at - start_at
    end
    
    def self.goodles_to_spend(user)
      return 0 unless user.goodles
      goodles_liquid = user.goodles - Auction.bid_liability(user)
      return 0 if goodles_liquid <= 0
      goodles_liquid.to_i
    end
    
    def self.find_by_highest_bidder(user)
      self.all.select do |auction|
        if auction.high_bidder == user
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
    
    def empty_bid
      temp_bid.new(temp_owner.new("None", 0), reserve.to_i, "None")
    end
    
    def temp_bid
      @temp_bid ||= Struct.new("TempBid", :owner, :goodles, :owner_name)
    end
    
    def temp_owner
      @temp_owner ||= Struct.new("TempOwner", :full_name, :goodles)
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
      dateselect_parse(auction_params) + auction_params[:duration].to_i.seconds
    end
    
    def self.dateselect_parse(auction_params)
      year  = auction_params["start_at(1i)"].to_i
      month = auction_params["start_at(2i)"].to_i
      day   = auction_params["start_at(3i)"].to_i
      hour  = auction_params["start_at(4i)"].to_i
      min   = auction_params["start_at(5i)"].to_i
      DateTime.new(year, month, day, hour, min)
    end
  end
end
