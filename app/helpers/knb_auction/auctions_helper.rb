module KnbAuction
  module AuctionsHelper
    
    def start_at_local_time( auction )
      auction.start_at.localtime
    end
    
    def end_at_local_time( auction )
      auction.end_at.localtime
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
    
    def bid_owner_name( bid )
      if current_user.admin?
        bid.owner_name
        # concat link_to(auction.high_bid.owner_name, auction.high_bidder)
      elsif current_user == bid.owner
        if current_user == bid.auction.high_bidder && bid.goodles == bid.auction.high_bid.goodles && bid.auction.active? 
          "You're winning!"
        elsif current_user == bid.auction.high_bidder && bid.goodles == bid.auction.high_bid.goodles && bid.auction.closed?
          "You won!"
        else
          "You"
        end
      else
        "Another goodler"
      end
    end
    
    def auction_time_left( auction )
      distance_of_time_in_words_to_now(auction.end_at)
    end
    
  end
end
