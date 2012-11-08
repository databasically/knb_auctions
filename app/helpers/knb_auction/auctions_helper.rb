module KnbAuction
  module AuctionsHelper
    
    def start_at_local_time( auction )
      auction.start_at.localtime
    end
    
    def end_at_local_time( auction )
      auction.end_at ? auction.end_at.localtime : (auction.start_at + 2.weeks).localtime
    end
  end
end
