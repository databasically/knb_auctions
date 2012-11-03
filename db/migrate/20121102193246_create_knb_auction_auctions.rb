class CreateKnbAuctionAuctions < ActiveRecord::Migration
  def change
    create_table :knb_auction_auctions do |t|
      t.integer :start_price
      t.datetime :start_at
      t.datetime :end_at
      t.integer :product_id
      t.integer :created_by_id

      t.timestamps
    end
  end
end
