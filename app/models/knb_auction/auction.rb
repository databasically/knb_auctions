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
    
    has_one :product
    has_many :bids
    
    #Scopes
    def self.active
      where("start_at <= :now AND end_at >= :now", now: Time.now ).order('start_at asc')
    end

    def self.closed
      where("end_at <= :now", now: Time.now ).order('start_at asc')
    end

    def self.upcoming
      where("start_at >= :now", now: Time.now ).order('start_at asc')
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
  end
end
