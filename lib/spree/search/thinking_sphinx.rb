module Spree::Search
  class ThinkingSphinx < Spree::Core::Search::Base

    protected

      def get_base_scope
        ts_base_scope = Spree::Product.ts_is_active
        ts_base_scope = ts_base_scope.ts_in_taxon(taxon) unless taxon.blank?
        base_scope = get_products_conditions_for(ts_base_scope, keywords)
        base_scope = add_search_scopes(base_scope)
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
  