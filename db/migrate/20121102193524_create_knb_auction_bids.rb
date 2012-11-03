class CreateKnbAuctionBids < ActiveRecord::Migration
  def change
    create_table :knb_auction_bids do |t|
      t.integer :owner_id
      t.datetime :bid_at
      t.integer :amount
      t.integer :auction_id

      t.timestamps
    end
  end
end
