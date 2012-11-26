require_dependency "knb_auction/application_controller"

module KnbAuction
  class DashboardController < ApplicationController
    def index
      redirect_to :auction  => 'index' and return
    end
  
    def show
    end
  end
end
