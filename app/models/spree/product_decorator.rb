module Spree
  Product.class_eval do
  	include ThinkingSphinx::Scopes

    class_attribute :indexed_options
    self.indexed_options = []

    sphinx_scope(:ts_is_active) do 
    	{ with: { is_active: true } }
    end

    sphinx_scope(:ts_in_taxon) do |taxon_ids|
    	{ with: { taxon_ids: taxon_ids } }
    end


  end
end