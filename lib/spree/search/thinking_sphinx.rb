module Spree::Search
  class ThinkingSphinx < Spree::Core::Search::Base

    def retrieve_products
      @products_scope = get_base_scope
      @products = @products_scope.search(page: page, per_page: per_page, sql: { includes: [:master => :prices] })
    end

    protected

      def get_base_scope
        ts_base_scope = Spree::Product.ts_is_active
        if taxon
          ts_base_scope = ts_base_scope.ts_in_taxon(taxon)
        elsif search
          taxon = Spree::Taxon.find_by_id(search.first[1].first[1].first[0])
          ts_base_scope = ts_base_scope.ts_in_taxon(taxon)
        end
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
          ts_base_scope = ts_base_scope.search(query)
        end
        ts_base_scope.search
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

