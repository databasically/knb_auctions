module KnbAuction
  class Bid < ActiveRecord::Base
    attr_accessible :amount, :bid_at, :owner_id
    
    has_and_belongs_to_many :auctions
  end
end
