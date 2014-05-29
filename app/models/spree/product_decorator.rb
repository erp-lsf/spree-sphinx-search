module Spree
  Product.class_eval do
  	include ThinkingSphinx::Scopes

    class_attribute :indexed_options
    self.indexed_options = []

    sphinx_scope(:ts_is_active) do
      { conditions: { :deleted_at => nil } }
    end

    sphinx_scope(:ts_in_taxon) do |taxon|
    	{ with: { taxon_ids: taxon.self_and_descendants.pluck(:id) } }
    end

    def is_active
      deleted_at == nil
    end

  end
end
