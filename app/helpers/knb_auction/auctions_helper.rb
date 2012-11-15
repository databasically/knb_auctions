module KnbAuction
  module AuctionsHelper
    
    def start_at_local_time( auction )
      auction.start_at.localtime
    end
    
    def end_at_local_time( auction )
      auction.end_at ? auction.end_at.localtime : (auction.start_at + 2.weeks).localtime
    end
    
    def status_label( status )
      haml_tag(:span, yield, class: "label #{status_labeler( status )}")
    end
    
    def status_labeler( status )
      case status
      when :active
        "label-success"
      when :closed
        "label-important"
      when :upcoming
        "label-warning"
      else
        "label-info"
      end
    end
    
    def bid_owner_name( auction )
      if current_user.admin?
        concat link_to(auction.high_bid.owner_name, auction.high_bidder)
      elsif current_user == auction.high_bidder
        "You're winning!"
      else
        "Another goodler"
      end
    end
    
  end
end
