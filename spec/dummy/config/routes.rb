Rails.application.routes.draw do

  resources :users

  mount KnbAuction::Engine => "/auction", :as => "auction_engine"
  
  resources :dashboard
  
  root :to => 'dashboard#index'
  

end
