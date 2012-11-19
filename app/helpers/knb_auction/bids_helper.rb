module KnbAuction
  module BidsHelper
    def minimum_bid(auction)
      minimum_bid_string = "Minimum Bid is"
      if auction.start_price > auction.high_bid.goodles
       "#{minimum_bid_string} #{auction.start_price} G"
      else
       "#{minimum_bid_string} #{auction.high_bid.goodles+1} G"
      end
    end
    
    def goodles_to_spend(user)
      Auction.bid_liability(user)
    end
  end
    
end
