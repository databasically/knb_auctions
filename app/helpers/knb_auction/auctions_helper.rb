module KnbAuction
  module AuctionsHelper
    
    def start_at_local_time( auction )
      auction.start_at.localtime
    end
    
    def end_at_local_time( auction )
      auction.end_at ? auction.end_at.localtime : (auction.start_at + 2.weeks).localtime
    end
    
    def status_label( status )
      case status
      when :active
        haml_tag(:span, yield, class: "label label-success")
      when :closed
        haml_tag(:span, yield, class: "label label-important")
      when :upcoming
        haml_tag(:span, yield, class: "label label-warning")
      else
        haml_tag(:span, yield, class: "label label-info")
      end 
    end
    
    def bid_owner_name( auction )
      if current_user.admin?
        auction.high_bid.owner_name
      elsif current_user == auction.high_bidder
        "You're winning!"
      else
        "Another goodler"
      end
    end
    
  end
end
