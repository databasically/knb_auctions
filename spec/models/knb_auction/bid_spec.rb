require 'spec_helper'

module KnbAuction
  describe Bid do
    let(:auction) { Auction.new(start_at: 1.months.ago, end_at: 1.month.from_now, product_id: 1, reserve: 100) }
    
    context "validates" do
      subject{ Bid.new(auction: auction) }
      
      it "bid with nil goodles" do
        bid = Bid.new(auction: auction)
        bid.should have(1).errors_on(:goodles)
      end 
      
      it "bid with less goodles than the reserve" do
        Auction.stub(:goodles_to_spend).and_return(101)
        
        bid = Bid.create(auction: auction, goodles: 99)
        bid.should have(2).errors_on(:goodles) #reserve not met and high bid not met
      end
      
      it "bid with less goodles than the current high bid but more than the reserve" do
        Auction.stub(:goodles_to_spend).and_return(106)
        auction.stub(:high_bid_goodles).and_return(110)
        
        bid = Bid.create(auction: auction, goodles: 105)
        bid.should have(1).errors_on(:goodles)
      end
      
      it "valid bid, but user doesn;t have enough goodles to spend" do
        Auction.stub(:goodles_to_spend).and_return(100)
        auction.stub(:high_bid_goodles).and_return(105)
        
        bid = Bid.create(auction: auction, goodles: 110)
        bid.should have(1).errors_on(:goodles)
      end
      
      it "valid bid, valid bankroll, auction is over" do
        Auction.stub(:goodles_to_spend).and_return(200)
        auction.stub(:high_bid_goodles).and_return(105)
        auction.end_at = 1.day.ago
        
        bid = Bid.create(auction: auction, goodles: 110)
        bid.should have(1).errors_on(:bid_at)
      end
      
    end      
  end
end