require 'spec_helper'

module KnbAuction
  describe Auction do
    # subject {Auction}
  
    # describe "filter by" do
    #   before(:all) do
    #     2.times {Auction.new(product_id: 1, start_at: 1.months.ago, end_at: 1.month.from_now).save}
    #     2.times {Auction.new(product_id: 1, start_at: 2.months.ago, end_at: 7.day.ago).save}
    #     2.times {Auction.new(product_id: 1, start_at: 7.day.from_now, end_at: 2.month.from_now).save}
    #   end
    # 
    it "does something" do
      a = Auction.new
      a.inspect
      a.should == 1
    end
    # 
    #   its (:all) {should have(6).auctions}  
    #   its(:active) {should have(2).auctions}
    #   its(:closed) {should have(2).auctions}
    #   its(:upcoming) {should have(2).auctions}
    # end
  end
end
