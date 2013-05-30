source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :development, :test do
    gem 'rspec-rails'
end

group :development do
  # add footnotes for more information
  gem 'rails-footnotes', '>= 3.7.9'
  # notification when eager loading (N+1 queries) necessary
  gem "bullet"
end

# outside of group test to be used in seed task
gem 'factory_girl_rails', require: false
gem 'faker'

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'selenium-webdriver'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'will_paginate', '~> 3.0'

# include bootstrap
gem "twitter-bootstrap-rails", :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

# memcache
gem 'dalli', :git => "git://github.com/mperham/dalli.git"
# gem 'dalli-store-extensions', :git => "git://github.com/defconomicron/dalli-store-extensions.git"

#better sql logging
gem "hirb"

# better web server
gem 'unicorn'

# better fragment caching
gem 'cache_digests'

# profiling and benchmarking
gem 'ruby-prof'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
