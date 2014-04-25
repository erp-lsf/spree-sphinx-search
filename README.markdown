Sphinx Search
=============

### Installation

1. Install Sphinx 2.1.7
1. Install Aspell 0.6 and at least one Aspell dictionary
      Mac:
        sudo port install aspell aspell-dict-en

      Ubuntu:
        sudo apt-get install aspell libaspell-dev aspell-en

1. `script/extension install git://github.com/pronix/spree-sphinx-search.git`
1. Copy config/sphinx.yml to RAILS_ROOT/config/sphinx.yml
1. Add migration to your application like this:

        class AddDeltaToProducts < ActiveRecord::Migration
          def change
            add_column :spree_products, :delta, :boolean, default: true, null: false
            add_index :spree_products, :delta
          end
        end



**NOTE:** This extension works only with Spree 0.30 and higher.

### Usage

To perform the indexing:

    rake ts:index

To start Sphinx for development:

    cd RAILS_ROOT/config
    sphinxd --config development.sphinx.conf
