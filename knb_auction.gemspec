$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "knb_auction/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "knb_auction"
  s.version     = KnbAuction::VERSION
  s.authors     = ["Chad Metcalf"]
  s.email       = ["chad@databasically.com"]
  s.homepage    = "http://databasically.com"
  s.summary     = "Auction functionality of KidsNBids.com"
  s.description = "KNB-Auctions is the Auction engine for KidsNBids.com. This engine handles auction administration, auction viewing, and auction bidding"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "haml-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "pg"
  s.add_dependency "delayed_job_active_record"
  s.add_dependency "twitter-bootstrap-rails"
  s.add_dependency 'bootstrap-datetimepicker-rails'
  s.add_dependency 'will_paginate', '~> 3.0'
  s.add_dependency 'will_paginate-bootstrap'
  
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "thin"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency 'ruby_gntp'
  s.add_development_dependency 'rb-fsevent', '~> 0.9.1'

end
