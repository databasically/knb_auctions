class CreateKnbAuctionProducts < ActiveRecord::Migration
  def change
    create_table :knb_auction_products do |t|
      t.text :name
      t.text :description
      t.integer :price
      t.column :sku, :bigint
      t.column :upc, :bigint
      t.boolean :approved
      t.integer :supplier_id

      t.timestamps
    end
  end
end