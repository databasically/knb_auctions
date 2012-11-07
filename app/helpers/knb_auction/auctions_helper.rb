module KnbAuction
  module AuctionsHelper
    
    def start_at_local_time( auction )
      auction.start_at.localtime
    end
  end
end
