ThinkingSphinx::Index.define 'spree/product', :with => :active_record do
  is_active_sql = "(spree_products.deleted_at IS NULL AND spree_products.available_on <= NOW())"

  indexes :name
  indexes :description
  indexes :meta_description
  indexes :meta_keywords
  has is_active_sql, :as => :is_active, :type => :boolean
  indexes taxons.name, :as => :taxon, :facet => true

  has taxons(:id), :as => :taxon_ids
  group_by :deleted_at
  group_by :available_on
  
end