module KnbAuction
  module AuctionsHelper
    
    def status_label( status )
      haml_tag(:span, yield, class: "label #{status_labeler( status )}")
    end
    
    def status_labeler( status )
      case status
      when :active
        "label label-success"
      when :closed
        "label label-important"
      when :upcoming
        "label label-warning"
      else
        "label label-info"
      end
    end
    
    def bid_owner_name( bid )
      return "" unless @active_child
      return bid.owner_name if current_user.admin?
      return "" unless @active_child == bid.owner
      
      if @active_child == bid.auction.high_bidder && bid.goodles == bid.auction.high_bid.goodles && bid.auction.active? 
        "You're winning!"
      elsif @active_child == bid.auction.high_bidder && bid.goodles == bid.auction.high_bid.goodles && bid.auction.closed?
        "You won!"
      else
        "You"
      end
    end
    
    def auction_time_left( auction )
      distance_of_time_in_words_to_now(auction.end_at)
    end
    
    def auction_product_name( auction )
      link_to auction.product_name.upcase, auction
    end
    
  end
end
