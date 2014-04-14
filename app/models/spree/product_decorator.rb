module Spree
  Product.class_eval do
  	include ThinkingSphinx::Scopes

    class_attribute :indexed_options
    self.indexed_options = []

    sphinx_scope(:ts_is_active) do 
    	{ with: { is_active: true } }
    end

    sphinx_scope(:ts_in_taxon) do |taxon|
    	{ with: { taxon_ids: taxon.self_and_descendants.pluck(:id) } }
    end

  end
end
