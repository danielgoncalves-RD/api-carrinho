# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.1'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'

gem 'bootsnap', require: false
gem 'puma', '>= 5.0'
gem 'tzinfo-data', platforms: %i[windows jruby]

gem 'redis', '~> 5.2'
gem 'sidekiq', '~> 7.2', '>= 7.2.4'
gem 'sidekiq-scheduler', '~> 5.0', '>= 5.0.3'

gem 'guard'
gem 'guard-livereload', require: false

gem 'sidekiq-cron'

gem 'pry-byebug'
gem 'pry-rails'

gem 'rubocop', '~> 0.42.0'

gem 'mongoid', '~> 9.0'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.1.0'
end

group :test do
  gem 'database_cleaner-mongoid'
  gem 'mongoid-rspec'
end

group :development do
end
