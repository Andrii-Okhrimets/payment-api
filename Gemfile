# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'pg', '1.5.9'
gem 'puma', '6.4.3'
gem 'rails', '~> 7.2.2'

gem 'interactor', '3.1.2'

## Rswag
gem 'rswag', '2.15.0'
gem 'rswag-api', '2.15.0'
gem 'rswag-ui', '2.15.0'

# JSON serialization
gem 'active_model_serializers', '0.10.14'
# CORS support
gem 'rack-cors', '2.0.2', require: 'rack/cors'

gem 'rest-client', '2.1.0'

# Authorization policies
gem 'pundit', '2.0.1'

### Pagination
gem 'kaminari'

#### Background jobs
gem 'redis', '5.3.0'
gem 'sidekiq-cron', '~> 2.1'

group :development, :test do
  gem 'bullet', '7.2.0'

  # sometimes we need to build fake entities on these environments for testing
  gem 'annotate'
  gem 'factory_bot_rails'
  gem 'faker', '3.5.1'

  # For debugging
  gem 'pry', '0.14.2'
  gem 'pry-byebug', '3.10.1'
  gem 'pry-rails', '0.3.11'

  # Code quality
  gem 'brakeman', '6.2.2', require: false
  gem 'bundle-audit', require: false
  gem 'lefthook', require: false
  gem 'rails_best_practices', require: false
  gem 'rubocop', '1.68.0', require: false
  gem 'rubocop-factory_bot', '2.26.1', require: false
  gem 'rubocop-faker', '1.2.0', require: false
  gem 'rubocop-performance', '1.22.1', require: false
  gem 'rubocop-rails', '2.27.0', require: false
  gem 'rubocop-rspec', '3.2.0', require: false
  gem 'rubocop-rspec_rails', '2.30.0', require: false
end

group :test do
  gem 'capybara', '3.40.0'
  gem 'database_cleaner', '2.1.0'
  gem 'json_matchers', '~> 0.11.1', require: 'json_matchers/rspec'
  gem 'json-schema-generator', '~> 0.0.9'
  gem 'json_spec', '1.1.5'
  gem 'rails-controller-testing', '1.0.5'
  gem 'rspec_junit_formatter', '0.6.0'
  gem 'rspec-rails', '7.0.1'
  gem 'rspec-sidekiq', '5.0.0'
  gem 'rswag-specs', '2.15.0'
  gem 'shoulda-matchers', '6.4.0'
  gem 'simplecov', '0.22.0', require: false
end
