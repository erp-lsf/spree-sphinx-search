module Spree
  class SphinxSearchConfiguration < Spree::Preferences::Configuration
    preference :product_price_ranges, :string, default: ["Under $25", "$25 to $50", "$50 to $100", "$100 to $200", "$200 and above"]
  end
end