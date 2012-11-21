class CreateKnbAuctionAuctions < ActiveRecord::Migration
  def change
    create_table :knb_auction_auctions do |t|
      t.integer :reserve, default: 0, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.integer :product_id
      t.integer :created_by_id

      t.timestamps
    end
  end
end
