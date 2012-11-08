module KnbAuction
  class Product < ActiveRecord::Base
    attr_accessible :approved, :description, :name, :price, :sku, :supplier_id, :upc
    
    has_many :auctions
    
    validates_presence_of :name, :on => :create, :message => "can't be blank"
    
    def self.approved
      where(approved: true).order('name asc')
    end
  end
end
