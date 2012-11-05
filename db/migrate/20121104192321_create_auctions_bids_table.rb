class CreateAuctionsBidsTable < ActiveRecord::Migration
  def change
    create_table :auctions_bids, :id => false do |t|
      t.integer :auction_id
      t.integer :bid_id
    end
  end
end
