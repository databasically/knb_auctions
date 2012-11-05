Rails.application.routes.draw do

  mount KnbAuction::Engine => "/auction", :as => "auction_engine"
  
  resources :dashboard
  
  root :to => 'dashboard#index'
  

end
