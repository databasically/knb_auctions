class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :quantity
      t.string :sku
      t.string :upc
      t.integer :a_supplier_profile_id
      t.boolean :approved
      t.integer :products_assets
      t.integer :assets

      t.timestamps
    end
  end
end
