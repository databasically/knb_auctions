Rails.application.routes.draw do

  mount KnbAuction::Engine => "/auction", :as => "auction_engine"
end
