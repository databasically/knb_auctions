module KnbAuction
  class Product < ActiveRecord::Base
    attr_accessible :approved, :description, :name, :price, :sku, :supplier_id, :upc
    
    has_many :auctions
    
    def self.approved
      where(approved: true).order('name asc')
    end
  end
end
