require_dependency "knb_auction/application_controller"

module KnbAuction
  class AuctionsController < ApplicationController
    before_filter :authenticate_user!, :except => [:index]
    
    # GET /auctions
    # GET /auctions.json
    def index      
      filter = params[:filter] || "none" 
      
      if Auction.respond_to?(filter)
        @title = "#{filter.titleize} Auctions"
        @auctions = Auction.try( filter ).sort_by(&:end_at)
      else
        @title = "Auctions"
        @auctions = Auction.active.sort_by(&:end_at)
      end
      
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @auctions }
      end
    end
  
    # GET /auctions/1
    # GET /auctions/1.json
    def show
      @auction = Auction.find(params[:id])
      @bids = @auction.bids.sort_by(&:bid_at).reverse
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @auction }
      end
    end
  
    # GET /auctions/new
    # GET /auctions/new.json
    def new
      @auction = Auction.new
      @product_dropdown = Product.approved
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @auction }
      end
    end
  
    # GET /auctions/1/edit
    def edit
      @product_dropdown = Product.approved
      @auction = Auction.find(params[:id])      
    end
  
    # POST /auctions
    # POST /auctions.json
    def create      
      @auction = Auction.new_for_auction(params[:auction])
  
      respond_to do |format|
        if @auction.save
          format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
          format.json { render json: @auction, status: :created, location: @auction }
        else
          format.html { render action: "new" }
          format.json { render json: @auction.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /auctions/1
    # PUT /auctions/1.json
    def update
      @product_dropdown = Product.approved
      @auction = Auction.find(params[:id])
  
      respond_to do |format|
        if @auction.update_attributes_for_auction(params[:auction])
          format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @auction.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /auctions/1
    # DELETE /auctions/1.json
    def destroy
      @auction = Auction.find(params[:id])
      @auction.destroy
  
      respond_to do |format|
        format.html { redirect_to auctions_url }
        format.json { head :no_content }
      end
    end
  end
end
