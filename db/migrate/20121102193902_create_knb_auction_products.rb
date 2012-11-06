class CreateKnbAuctionProducts < ActiveRecord::Migration
  def change
    create_table :knb_auction_products do |t|
      t.text :name, default: "", null: false
      t.text :description, default: "", null: false
      t.integer :price
      t.column :sku, :bigint
      t.column :upc, :bigint
      t.boolean :approved, default: false, null: false
      t.integer :supplier_id

      t.timestamps
    end
  end
end