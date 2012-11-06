module KnbAuction
  class Bid < ActiveRecord::Base
    attr_accessible :amount, :bid_at, :owner_id
    
    belongs_to :auctions
  end
end
