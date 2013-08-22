# t.integer  "owner_id"
# t.datetime "bid_at"
# t.integer  "goodles"
# t.integer  "auction_id"
# t.datetime "created_at", :null => false
# t.datetime "updated_at", :null => false

module KnbAuction
  class Bid < ActiveRecord::Base
    belongs_to :owner, :class_name => "Child"
    belongs_to :auction
    
    attr_accessible :goodles, :bid_at, :owner, :owner_id, :auction_id, :auction
    
    validates_presence_of :auction
    validates_presence_of :bid_at
    validates_numericality_of :goodles
    
    validate :auction_open
    validate :reserve_met
    validate :high_bid
    validate :bankroll
    
    before_validation :default_values
    
    def default_values
      self.bid_at ||= DateTime.now
    end
    
    def owner_name
      owner.name
    end
    
    def high_bid
      if !goodles.nil? && auction.high_bid_goodles >= goodles
        errors.add(:goodles, "must be more than the current high bid of #{auction.high_bid.goodles} goodles")
      end
    end
    
    def bankroll
      if !goodles.nil? &&  Auction.goodles_to_spend(owner) < goodles
        errors.add(:goodles, "must be less than your maximum bid of #{Auction.goodles_to_spend(owner)}")
      end
    end
    
    def reserve_met
      if !goodles.nil? && auction.reserve > goodles
        errors.add(:goodles, "must be greater than the reserve price of #{auction.reserve} goodles")
      end
    end
    
    def auction_open
      unless (auction.start_at <= bid_at) && (auction.end_at >= bid_at)
        errors.add(:bid_at, "Auction isn't open")
      end
    end
    
  end
end
