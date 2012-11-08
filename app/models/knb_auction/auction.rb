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
    attr_accessor :duration_string, :duration, :start_at_localtime, :status, :highest_bidder
    
    belongs_to :product
    has_many :bids
    
    validates_presence_of :product_id
    validates_associated :product
    validates_presence_of :start_at, :message => "cannot be blank."
    validates_presence_of :end_at, :message => "cannot be blank."
    
    before_save :duration_string_to_end_time
    before_save :start_time_to_utc
    
    after_initialize :initialize_working_variables
    
    def initialize_working_variables
      if end_at
        @duration = start_at - end_at
      end
      
      @status = auction_state_by_datetime
      
      @start_at_localtime = start_at.localtime
    end
    
    #Scopes
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
      @high_bid ||= bids.sort_by(&:goodles).last
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
    
    def duration_string_to_end_time
      # duration_string.call
    end
    
    def start_time_to_utc
    end
  end
end
