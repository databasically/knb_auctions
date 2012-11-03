module KnbAuction
  class Bid < ActiveRecord::Base
    attr_accessible :amount, :auction_id, :bid_at, :owner_id
  end
end
