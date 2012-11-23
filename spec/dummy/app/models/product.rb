class Product < ActiveRecord::Base
  attr_accessible :a_supplier_profile_id, :approved, :assets, :description, :name, :price, :products_assets, :quantity, :sku, :upc
end
