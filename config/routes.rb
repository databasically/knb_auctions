KnbAuction::Engine.routes.draw do
  
  get "dashboard/index"

  get "dashboard/show"

  root :to => "dashboard#index" 
end
