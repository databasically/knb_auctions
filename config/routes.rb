KnbAuction::Engine.routes.draw do
    
  resources :auctions do
    resources :bids
  end

  root :to => 'auctions#index' 
end
