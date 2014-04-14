module Spree::Search
  class ThinkingSphinx < Spree::Core::Search::Base

    def retrieve_products
      @products_scope = get_base_scope
      curr_page = page || 1

      @products = @products_scope.includes([:master => :prices])
      unless Spree::Config.show_products_without_price
        @products = @products.where("spree_prices.amount IS NOT NULL").where("spree_prices.currency" => current_currency)
      end
      @products = @products.page(curr_page).per(per_page)
    end

    protected

      def get_base_scope
        ts_base_scope = Spree::Product.ts_is_active
        ts_base_scope = ts_base_scope.ts_in_taxon(taxon) unless taxon.blank?
        ts_base_scope = add_search_scopes(ts_base_scope)
        base_scope = get_products_conditions_for(ts_base_scope, keywords)
        base_scope
      end


      def add_search_scopes(base_scope)
        search.each do |name, scope_attribute|
          scope_name = name.to_sym
          base_scope = base_scope.send(scope_name, *scope_attribute)
        end if search
        base_scope
      end
     
      # method should return new scope based on base_scope
      def get_products_conditions_for(ts_base_scope, query)
        unless query.blank?
          ts_base_scope = ts_base_scope.search_for_ids(query)
        end
        Spree::Product.where("spree_products.id IN (?)", ts_base_scope.search_for_ids)
      end

      def prepare(params)
        @properties[:taxon] = params[:taxon].blank? ? nil : Spree::Taxon.find(params[:taxon])
        @properties[:keywords] = params[:keywords]
        @properties[:search] = params[:search]

        per_page = params[:per_page].to_i
        @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
        @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
      end
  end
end
  