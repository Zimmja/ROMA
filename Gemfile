# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# gem "rails"

gem 'sinatra'
gem 'sinatra-contrib'
gem 'webrick'

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development, :test do
  gem 'capybara'
  gem 'pg'
  gem 'rubocop'
  gem 'selenium-webdriver'
end
