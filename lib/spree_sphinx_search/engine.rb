module SpreeSphinxSearch
  class Engine < Rails::Engine
    engine_name 'spree_sphinx_search'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      if Spree::Config.instance
        Spree::Config.searcher_class = Spree::Search::ThinkingSphinx
        Spree::Config.set(:product_price_ranges => ["Under $25", "$25 to $50", "$50 to $100", "$100 to $200", "$200 and above"])
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
