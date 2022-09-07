# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'
gem 'bootsnap', require: false
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'devise'
gem 'devise-bootstrap-views'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'devise_masquerade'

gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'bootstrap'
gem 'sassc-rails'

gem 'pay'
gem 'stripe'

gem 'redcarpet'

gem 'rating'
gem 'sidekiq'

gem 'sib-api-v3-sdk'

gem 'administrate'

gem 'brakeman'
gem 'bundler-audit'
gem 'rubocop', require: false
gem 'rubocop-rails', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'letter_opener'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
