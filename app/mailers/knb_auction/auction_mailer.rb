module KnbAuction
  class AuctionMailer < ActionMailer::Base
    default from: "auctions@kidsnbids.com"
    
    def admin_auction_is_over(auction)
      @auction = auction
      @child = auction.high_bidder
      @bid = auction.high_bid
      
      mail(:to => User.auction_admin, :subject => "[KNB Auction] Auction for #{truncate(@auction.product_name, length: 25)} Over")
    end
    
    def guardian_auction_is_over(auction)
      
    end
    
    
    
    
  end
end
