module Spree
  Product.class_eval do
    class_attribute :indexed_options
    self.indexed_options = []
  end
end