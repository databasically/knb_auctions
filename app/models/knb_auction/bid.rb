# t.integer  "owner_id"
# t.datetime "bid_at"
# t.integer  "goodles"
# t.integer  "auction_id"
# t.datetime "created_at", :null => false
# t.datetime "updated_at", :null => false

module KnbAuction
  class Bid < ActiveRecord::Base
    belongs_to :owner, :class_name => "User"
    belongs_to :auction
    
    attr_accessible :goodles, :bid_at, :owner_id, :auction_id
    
    validates_presence_of :auction_id
    
    # validate :auction_open
    validate :reserve_met
    validate :high_bid
    validate :bankroll

    
    def owner_name
      owner.full_name
    end
    
    def high_bid
      if auction.high_bid.goodles >= goodles
        errors.add(:goodles, "must be more than the current high bid of #{auction.high_bid.goodles} goodles")
      end
    end
    
    def bankroll
      if Auction.bid_liability(owner) > owner.goodles
        errors.add(:goodles, "must be less than your maximum bid of #{owner.goodles - Auction.bid_liability(owner)}")
      end
    end
    
    def reserve_met
      if auction.start_price > goodles
        errors.add(:goodles, "must be greater than the reserve price of #{auction.start_price} goodles")
      end
    end
    
    def auction_open
      unless (auction.start_at <= updated_at) && (auction_end_at >= updated_at)
        errors.add(:bid_at, "Auction isn't open")
      end
    end
    
  end
end
