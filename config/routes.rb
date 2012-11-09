KnbAuction::Engine.routes.draw do
  
  resources :products
  
  resources :auctions do
    resources :bids
  end

  root :to => 'auctions#index' 
end
