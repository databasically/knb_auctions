require 'spec_helper'

module KnbAuction
  require 'timecop'
  
  describe Auction do
    let(:product) { Product.find_or_create_by_name("A generic Toy") }
    context "filter by" do  
      subject {Auction}
          
      before(:each) do
        2.times {Auction.create(start_at: 1.months.ago, end_at: 1.month.from_now, product: product)}
        2.times {Auction.create(start_at: 2.months.ago, end_at: 7.day.ago, product: product)}
        2.times {Auction.create(start_at: 7.day.from_now, end_at: 2.month.from_now, product: product)}
      end

      its(:all) {should have(6).auctions}  
      its(:active) {should have(2).auctions}
      its(:closed) {should have(2).auctions}
      its(:upcoming) {should have(2).auctions}
    end
    
    context "lifecycle" do
      let(:child) { Child.create(full_name: "Yukon Cornelious", goodles: 2000) }
      
      it "deducts after completion" do
        auction = Auction.create(start_at: 1.week.ago, end_at: 1.week.from_now, product: product)
        KnbAuction::Bid.create(auction: auction, goodles: 200, owner: child)
        expect(child.goodles).to eql(2000)
        Timecop.travel(2.weeks.from_now)
        DelayedJobSpecHelper.work_off
        child.reload
        expect(child.goodles).to eql(1800)
      end
    end
    # context "returns" do
    #   
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
