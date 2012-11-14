require 'spec_helper'

module KnbAuction
  describe Bid do
    context "validations" do
      subject{ Bid.new }
      
      it { should have(1).error_on(:goodles) }
      
    end
  end
end