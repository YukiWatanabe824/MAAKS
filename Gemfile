# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'devise', '~> 4.9'
gem 'devise-i18n'
gem 'image_processing', '~> 1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'meta-tags'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.5', '>= 7.0.5.1'
gem 'rails-i18n'
gem 'redis', '~> 5.0'
gem 'sentry-rails', '~> 5.12'
gem 'slim-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'rubocop-fjord', require: false
  gem 'rubocop-rails', require: false
  gem 'slim_lint', require: false
end

group :development do
  gem 'bullet'
  gem 'dockerfile-rails', '>= 1.5'
  gem 'html2slim'
  gem 'letter_opener_web', '~> 2.0'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end
