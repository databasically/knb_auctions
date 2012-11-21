module KnbAuction
  module BidsHelper
    def minimum_bid(auction)
      minimum_bid_string = "The minimum bid is"
      if auction.start_price > auction.high_bid.goodles
       "#{minimum_bid_string} #{auction.start_price} G"
      else
       "#{minimum_bid_string} #{auction.high_bid.goodles+1} G"
      end
    end
    
    def goodles_to_spend(user)
      Auction.goodles_to_spend(user)
    end
  end
    
end
