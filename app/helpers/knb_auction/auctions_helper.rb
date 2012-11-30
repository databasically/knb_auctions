module KnbAuction
  module AuctionsHelper
    
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
      return "" unless current_user
      return bid.owner_name if current_user.admin?
      return "" unless current_user == bid.owner
      
      if current_user == bid.auction.high_bidder && bid.goodles == bid.auction.high_bid.goodles && bid.auction.active? 
        "You're winning!"
      elsif current_user == bid.auction.high_bidder && bid.goodles == bid.auction.high_bid.goodles && bid.auction.closed?
        "You won!"
      else
        "You"
      end
    end
    
    def auction_time_left( auction )
      distance_of_time_in_words_to_now(auction.end_at)
    end
    
  end
end
