Deface::Override.new( :virtual_path => 'spree/shared/_products',
                      :name => 'Change condition for pagination',
                      :replace => %Q(erb[silent]:contains('if paginated_products.respond_to?(:num_pages)'))) do

%Q(
  <% if paginated_products.respond_to?(:current_page) %>
  )
end

