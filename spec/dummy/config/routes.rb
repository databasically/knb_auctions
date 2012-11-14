Rails.application.routes.draw do

  devise_for :users

  resources :users

  mount KnbAuction::Engine => "/auction", :as => "auction_engine"
  
  resources :dashboard
  
  root :to => 'dashboard#index'
  

end
