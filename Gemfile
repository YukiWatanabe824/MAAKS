# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'devise'
gem 'devise-i18n'
gem 'image_processing'
gem 'importmap-rails'
gem 'jbuilder'
gem 'meta-tags'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy'
gem 'pg'
gem 'puma'
gem 'rails', '7.1.3'
gem 'rails-i18n'
gem 'redis'
gem 'sentry-rails'
gem 'slim-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot_rails', require: false
  gem 'rspec-rails', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-fjord', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'slim_lint', require: false
end

group :development do
  gem 'bullet'
  gem 'dockerfile-rails'
  gem 'html2slim'
  gem 'letter_opener_web'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end
