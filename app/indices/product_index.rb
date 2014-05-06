ThinkingSphinx::Index.define 'spree/product', with: :real_time do

  indexes :name
  indexes :description
  indexes :meta_description
  indexes :meta_keywords
  indexes taxons.name, as: :taxon, facet: true

  has is_active, type: :boolean
  has master.default_price.amount, as: :product_price, type: :float
  if Spree::Price.column_names.include? "old_amount"
    has master.default_price.old_amount, as: :product_old_price, type: :float
  end
  has taxon_ids, as: :taxon_ids, type: :integer, multi: true
end
