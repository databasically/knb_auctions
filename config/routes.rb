KnbAuction::Engine.routes.draw do
  
  resources :products

  resources :bids

  resources :auctions

  root :to => 'auctions#index' 
end
