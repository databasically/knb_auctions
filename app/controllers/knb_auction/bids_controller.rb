require_dependency "knb_auction/application_controller"

module KnbAuction
  class BidsController < ApplicationController
    before_filter :authenticate_user!
    
    
    # GET /bids
    # GET /bids.json
    # def index
    #   @auction = Auction.find(params[:auction_id])
    #   @bids = Bid.all.sort_by(&:bid_at).reverse
    #   
    #   respond_to do |format|
    #     format.html # index.html.erb
    #     format.json { render json: @bids }
    #   end
    # end
  
    # GET /bids/1
    # GET /bids/1.json
    # def show
    #   @auction = Auction.find(params[:auction_id])
    #   @bid = Bid.find(params[:id])
    #   
    #   respond_to do |format|
    #     format.html # show.html.erb
    #     format.json { render json: @bid }
    #   end
    # end
  
    # GET /bids/new
    # GET /bids/new.json
    def new
      @auction = Auction.find(params[:auction_id])
      @bid = Bid.new
        
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @bid }
      end
    end
  
    # GET /bids/1/edit
    def edit
      @auction = Auction.find(params[:auction_id])
      @bid = Bid.find(params[:id])
    end
  
    # POST /bids
    # POST /bids.json
    def create
      @auction = Auction.find(params[:auction_id])
      params[:bid].reverse_merge!({owner_id: current_user.id})
      @bid = @auction.bids.build(params[:bid])
  
      respond_to do |format|
        if @bid.save
          format.html { redirect_to @auction, notice: 'You submitted a bid!'}
          format.json { render json: @bid, status: :created, location: @bid }
        else
          format.html { render action: "new" }
          format.json { render json: @bid.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /bids/1
    # PUT /bids/1.json
    def update
      @auction = Auction.find(params[:auction_id])
      params[:bid].reverse_merge!({owner_id: current_user.id})
      @bid = Bid.find(params[:id])
  
      respond_to do |format|
        if @bid.update_attributes(params[:bid])
          format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @bid.errors, status: :unprocessable_entity }
        end
      end
      
      redirect_to @auction and return
    end
  
    # DELETE /bids/1
    # DELETE /bids/1.json
    def destroy
      @auction = Auction.find(params[:auction_id])
      @bid = Bid.find(params[:id])
      @bid.destroy
  
      respond_to do |format|
        format.html { redirect_to @auction }
        format.json { head :no_content }
      end
    end
  end
end
