require "spec_helper"

module KnbAuction
  describe AuctionsController do
    describe "routing" do

      xit "routes to #index" do
        get("/auctions").should route_to("auctions#index")
      end

      xit "routes to #new" do
        get("/auctions/new").should route_to("auctions#new")
      end

      xit "routes to #show" do
        get("/auctions/1").should route_to("auctions#show", :id => "1")
      end

      xit "routes to #edit" do
        get("/auctions/1/edit").should route_to("auctions#edit", :id => "1")
      end

      xit "routes to #create" do
        post("/auctions").should route_to("auctions#create")
      end

      xit "routes to #update" do
        put("/auctions/1").should route_to("auctions#update", :id => "1")
      end

      xit "routes to #destroy" do
        delete("/auctions/1").should route_to("auctions#destroy", :id => "1")
      end
    end

  end
end
