module Spree::SphinxSearch; end;

module SpreeSphinxSearch
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_sphinx_search'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.sphinx_search.preferences", :before => :load_config_initializers do |app|
      Spree::Config.searcher_class = Spree::Search::ThinkingSphinx
      Spree::SphinxSearch::Config = Spree::SphinxSearchConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
    
    config.to_prepare &method(:activate).to_proc
    
#    def load_tasks
#    end
  end
end
