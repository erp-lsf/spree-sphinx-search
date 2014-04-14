ThinkingSphinx::Index.define 'spree/product', :with => :active_record do
  is_active_sql = "(spree_products.deleted_at IS NULL AND spree_products.available_on <= NOW())"

  indexes :name
  indexes :description
  indexes :meta_description
  indexes :meta_keywords
  indexes taxons.name, :as => :taxon, :facet => true

  has is_active_sql, :as => :is_active, :type => :boolean
  has master.default_price.amount, as: :product_price, type: :float

  if Spree::Price.column_names.include? "old_amount"
  	has master.default_price.old_amount, as: :product_old_price, type: :float
  end

  has taxons(:id), :as => :taxon_ids
  
end