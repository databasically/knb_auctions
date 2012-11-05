module KnbAuction
  class Auction < ActiveRecord::Base
    attr_accessible :created_by_id, :end_at, :start_at, :start_price
    
    has_many :products
    has_and_belongs_to_many :bids
    
    #Scopes
    def self.active
      where("start_at <= :now AND end_at >= :now", now: Time.now ).order('start_at asc')
    end

    def self.closed
      where("end_at <= :now", now: Time.now ).order('start_at asc')
    end

    def self.upcoming
      where("start_at >= :now", time: Time.now ).order('start_at asc')
    end
    
    def product_name
      product.name
    end
    
    def bids_count
      bids.size
    end
  end
end
