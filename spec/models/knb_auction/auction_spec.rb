require 'spec_helper'

module KnbAuction
  describe Auction do
    let(:product) { Product.new(name: "A generic Toy") }
    context "filter by" do  
      subject {Auction}
          
      before(:each) do
        2.times {Auction.new(start_at: 1.months.ago, end_at: 1.month.from_now, product: product).save}
        2.times {Auction.new(start_at: 2.months.ago, end_at: 7.day.ago, product: product).save}
        2.times {Auction.new(start_at: 7.day.from_now, end_at: 2.month.from_now, product: product).save}
      end

      its(:all) {should have(6).auctions}  
      its(:active) {should have(2).auctions}
      its(:closed) {should have(2).auctions}
      its(:upcoming) {should have(2).auctions}
    end
    
    # context "returns" do
    #   let(:user) { Struct.new("User", :full_name, :goodles).new("Yukon Cornelious", 2000) }
    #   
    #   before(:each) do
    #     Auction.new(start_at: 1.months.ago, end_at: 1.month.from_now, product: product)
    #   end
    #   
    #   it "overall bid liability" do
    #     
    #     
    #     
    #   end
    # end
    
    
    
  end
end
