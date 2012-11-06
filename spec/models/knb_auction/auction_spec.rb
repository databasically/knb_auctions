require 'spec_helper'

module KnbAuction
  describe Auction do
    context "filter by" do  
      subject {Auction}
    
      before(:each) do
        2.times {Auction.new(start_at: 1.months.ago, end_at: 1.month.from_now).save}
        2.times {Auction.new(start_at: 2.months.ago, end_at: 7.day.ago).save}
        2.times {Auction.new(start_at: 7.day.from_now, end_at: 2.month.from_now).save}
      end

      its(:all) {should have(6).auctions}  
      its(:active) {should have(2).auctions}
      its(:closed) {should have(2).auctions}
      its(:upcoming) {should have(2).auctions}
    end
  end
  
  context "" do
    
  end
end
