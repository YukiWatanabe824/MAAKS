source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.5', '>= 7.0.5.1'

gem 'sprockets-rails'

gem 'pg', '~> 1.1'

gem 'puma', '~> 5.0'

gem 'importmap-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'tailwindcss-rails'

gem 'jbuilder'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'bootsnap', require: false

gem 'image_processing', '~> 1.2'

gem 'html2slim'

gem 'slim-rails'

gem 'devise', '~> 4.9'

gem 'omniauth-google-oauth2'

gem 'omniauth-rails_csrf_protection'

gem 'pagy'

gem 'rails-i18n'

gem 'devise-i18n'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop-fjord', require: false
  gem 'rubocop-rails', require: false
  gem 'slim_lint', require: false
end

group :development do
  gem 'bullet'
  gem 'letter_opener_web', '~> 2.0'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
