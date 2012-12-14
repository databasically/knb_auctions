class Product < ActiveRecord::Base
  attr_accessible :a_supplier_profile_id, :approved, :assets, :description, :name, :price, :products_assets, :quantity, :sku, :upc
    
  def main_image(size = :thumb)
    'http://www.kidsnbids.com/assets/logo.png'
  end
  
  def self.all
    all
  end
  
  def self.approved
    where(approved: true).order('name asc')
  end
  
  def self.not_approved
    where(approved: false).order('name asc')
  end
  
  def self.assets
    []
  end
end
