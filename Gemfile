# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'rack-cors'

gem 'active_model_serializers', '~> 0.10.14'
gem 'geocoder', '~> 1.8', '>= 1.8.2'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'database_cleaner', '~> 2.0', '>= 2.0.2'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rswag'
  gem 'rswag-api'
  gem 'rswag-ui'
  gem 'shoulda-matchers'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate', '~> 3.2'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.2'
  gem 'rubocop', '~> 1.57'
  gem 'rubocop-minitest', '~> 0.33.0', require: false
  gem 'rubocop-rails', '~> 2.23', require: false
  gem 'rubocop-rake', '~> 0.6.0', require: false
  gem 'rubocop-shopify', '~> 2.14', require: false
  gem 'rubocop-sorbet', '~> 0.7', require: false
  gem 'ruby-lsp', require: false
  gem 'solargraph'
  gem 'solargraph-rails', '~> 1.1'
end
