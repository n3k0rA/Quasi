source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'bcrypt-ruby', :require => 'bcrypt'
gem "authlogic"
gem 'ruby_parser'
gem 'hpricot'
gem 'haml'
gem 'nifty-generators' 
gem 'gmaps4rails'

group :production do
  # gems specifically for Heroku go here
  gem "pg"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem "haml-rails"
end

gem 'jquery-rails'

gem "paperclip", "~> 2.5.0"
gem "aws-s3"
gem "aws-sdk"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end
gem "mocha", :group => :test
