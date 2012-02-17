source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem "mysql2", "~> 0.3.11"
gem 'pg'

gem 'whois'
gem 'mechanize'
gem 'nokogiri', '1.5.0'
#gem 'htmldiff'  #compiled from source for a test

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'  
end

group :test do
  gem "rspec-rails", "~> 2.8.1"
  gem "capybara", "~> 1.1.2"
  gem "guard-rspec", "~> 0.6.0"
  gem "guard-livereload", "~> 0.4.0"
  gem "guard-cucumber", "~> 0.7.5"
  # Pretty printed test output
  gem "turn", "< 0.8.3", :require => false
  gem "cucumber-rails", "~> 1.2.1"
  gem "database_cleaner", "~> 0.7.1" #To be used to ensure a clean state for testing.
  gem "spork", "~> 0.9.0"
  gem "launchy", "~> 2.0.5"
  gem 'shoulda', '~> 3.0.0.beta'
  gem "libnotify", "~> 0.7.2"
  gem "factory_girl_rails", "~> 1.6.0"
  gem "ruby-debug19"
  gem "fakeweb"
  gem "mocha"
end



gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-identity'
