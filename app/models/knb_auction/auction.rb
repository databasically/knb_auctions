module KnbAuction
  class Auction < ActiveRecord::Base
    attr_accessible :created_by_id, :end_at, :product_id, :start_at, :start_price
  end
end
