module KnbAuction
  module BidsHelper
    def minimum_bid(auction)
      minimum_bid_string = "To bid on this item you must use at least"
      if auction.reserve > auction.high_bid.goodles
       "#{minimum_bid_string} #{auction.reserve} G"
      else
       "#{minimum_bid_string} #{auction.high_bid.goodles+1} G"
      end
    end
    
    def goodles_to_spend(user)
      Auction.goodles_to_spend(user)
    end
  end
    
end
