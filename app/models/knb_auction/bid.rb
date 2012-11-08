# t.integer  "owner_id"
# t.datetime "bid_at"
# t.integer  "goodles"
# t.integer  "auction_id"
# t.datetime "created_at", :null => false
# t.datetime "updated_at", :null => false

module KnbAuction
  class Bid < ActiveRecord::Base
    attr_accessible :goodles, :bid_at, :owner_id, :auction_id
    belongs_to :owner, :class_name => "User"
    belongs_to :auction
    
    validate :high_bid, :on => :create
    validate :bankroll, :on => :create
    
    def owner_name
      owner.name
    end
    
    def high_bid
      if self.auction.high_bid.goodles >= goodles
        errors.add(:goodles, "must be more than the current high bid of #{self.auction.high_bid} goodles")
      end
    end
    
    def bankroll
      if Auction.bid_liability(owner) > owner.goodles
        errors.add(:goodles, "must be less than your total liability of #{Auction.bid_liability(owner)}")
      end
    end
    
  end
end
