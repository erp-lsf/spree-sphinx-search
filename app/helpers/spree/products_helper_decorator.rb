module Spree
  ProductsHelper.module_eval do
    def cache_key_for_products
      if @products.respond_to?(:maximum)
        max_updated_at = @products.maximum(:updated_at).to_s(:number)
      else
        product_with_max_updated_at = @products.max_by{ |p| p.updated_at }
        max_updated_at = if product_with_max_updated_at
          product_with_max_updated_at.updated_at.to_s(:number)
        else
          max_updated_at = ""
        end
      end
      "#{current_currency}/spree/products/all-#{params[:page]}-#{max_updated_at}"
    end
  end
end
