Sphinx Search
=============

### Installation

1. Install Sphinx
1. Install Aspell and at least one Aspell dictionary
      Mac:
        sudo port install aspell aspell-dict-en

      Ubuntu:
        sudo apt-get install aspell libaspell-dev aspell-en

1. Add to Gemfile: gem 'spree_sphinx_search', :git => 'git://github.com/secoint/spree-sphinx-search.git', :branch => '0.70'
1. Run `rails g spree_sphinx_search:install`

**NOTE:** This extension works only with Spree 0.70

### Usage

To perform the indexing:

    rake ts:config
    rake ts:index

To start Sphinx for development:

    rake ts:start