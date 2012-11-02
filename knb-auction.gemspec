$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "knb-auction/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "KidsNBids Auction Engine"
  s.version     = KnbAuction::VERSION
  s.authors     = ["Chad Metcalf"]
  s.email       = ["chad@databasically.com"]
  s.homepage    = "http://databasically.com"
  s.summary     = "Auction functionality of KidsNBids.com"
  s.description = "KNB-Auctions is the Auction engine for KidsNBids.com. This engine handles product administration, auction administration, auction viewing, auction bidding, "

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "haml-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "pg"
  
  s.add_development_dependency "thin"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"

end
