module KnbAuction
  class Product < ActiveRecord::Base
    attr_accessible :approved, :description, :name, :price, :sku, :supplier_id, :upc
    
    has_many :auctions
  end
end
