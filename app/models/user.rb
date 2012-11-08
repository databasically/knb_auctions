def User
  attr_accessor :goodles
  
  def active_bid_liability
    KnbAuction::Auction.active.bid_liability(self)
  end
end