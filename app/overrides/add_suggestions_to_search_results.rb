Deface::Override.new(:virtual_path => "spree/products/index", 
                     :name => "Add suggestions to search results",
                     :insert_before => "div[data-hook='search_results']", 
                     :partial => "spree/products/suggestions")