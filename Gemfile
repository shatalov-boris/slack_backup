ruby "2.6.3"

source "https://rubygems.org"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.0"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1.0"
# Use Puma as the app server
gem "puma", "~> 3.12.0"
# Bootstrap
gem "bootstrap-sass"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Storing ENV variable
gem "figaro"

gem "devise"
gem "friendly_id" # Pretty urls
gem "gemoji" # Emoji support
gem "haml-rails"
gem "omniauth-slack"
gem "redis-rails"
gem "rest-client", require: false
gem "sidekiq"
gem "whenever", require: false

# Pagination
gem "bootstrap-kaminari-views"
gem "kaminari"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platform: :mri
  gem "pry-rails"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "bullet"
  gem "magic_frozen_string_literal", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
end
