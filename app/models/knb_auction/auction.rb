# t.integer  "start_price"
# t.datetime "start_at"
# t.datetime "end_at"
# t.integer  "product_id"
# t.integer  "created_by_id"
# t.datetime "created_at",    :null => false
# t.datetime "updated_at",    :null => false


module KnbAuction
  class Auction < ActiveRecord::Base
    attr_accessible :product_id, :created_by_id, :end_at, :start_at, :start_price
    attr_accessor :duration, :status, :highest_bidder
    
    belongs_to :product
    has_many :bids
    
    validates_presence_of :product_id
    validates_associated :product
    validates_presence_of :start_at, :message => "cannot be blank."
    validates_presence_of :end_at, :message => "cannot be blank."
    
    DURATION_WHITELIST = [['1 Day', 1.day.to_i], ['1 Week', 1.week.to_i], ['2 Weeks', 2.weeks.to_i], ['3 Weeks', 3.weeks.to_i], ['1 Month', 1.month.to_i]]
    
    after_initialize :initialize_working_variables
    
    def initialize_working_variables
      if start_at && end_at
        @status = auction_state_by_datetime
        # @start_at_localtime = start_at.localtime
      end
    end
    
    def self.create_from_new(options = {})
      defaults = {end_at: duration_to_end_at(options), start_at: dateselect_parse(options)}
      options.delete(:duration)
      options.reverse_merge!(defaults)
      Auction.new(options)
    end

    def self.active
      where("start_at <= :now AND end_at >= :now", now: Time.now ).order('start_at asc')
    end
    
    def active?
      time_now = Time.now
      (start_at <= time_now) && (end_at >= time_now)
    end

    def self.closed
      where("end_at <= :now", now: Time.now ).order('start_at asc')
    end
    
    def closed?
      now = Time.now
      end_at < now
    end

    def self.upcoming
      where("start_at >= :now", now: Time.now ).order('start_at asc')
    end
    
    def upcoming?
      now = Time.now
      start_at > now
    end
    
    def self.bid_liability(user)
      find_by_highest_bidder(user).inject(0) { |goodles, auction|  goodles += auction.high_bid.goodles}
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
    
    def self.approved_products
      Product.approved
    end
    
    def bids_count
      bids.size
    end
    
    def high_bid
      @high_bid ||= bids.sort_by(&:goodles).last || empty_bid
    end
    
    def empty_bid
      struct_bid = Struct.new("Bid", :owner, :goodles, :owner_name)
      struct_owner = Struct.new("Owner", :full_name, :goodles)
      struct_bid.new(struct_owner.new("None", 0), 0, "None")
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
    
    def self.duration_to_end_at(options = {})
      dateselect_parse(options) + options[:duration].to_i.seconds
    end
    
    def self.dateselect_parse(options)
      year  = options["start_at(1i)"].to_i
      month = options["start_at(2i)"].to_i
      day   = options["start_at(3i)"].to_i
      hour  = options["start_at(4i)"].to_i
      min   = options["start_at(5i)"].to_i
      DateTime.new(year, month, day, hour, min)
    end
  end
end
