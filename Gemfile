ruby "2.6.6"

source "https://rubygems.org"
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.2"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Bootstrap
gem "bootstrap-sass", "~> 3.4"
# Use SCSS for stylesheets
gem "sass-rails", "~> 6.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", "~> 4.2"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 5.0"

# Use jquery as the JavaScript library
gem "jquery-rails", "~> 4.3"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5.2"
# Storing ENV variable
gem "figaro", "~> 1.1"

gem "devise", "~> 4.7"
gem "friendly_id", "~> 5.3" # Pretty urls
gem "gemoji", "~> 3.0" # Emoji support
gem "haml-rails", "~> 2.0"
gem "omniauth-slack", "~> 2.3"
gem "redis-rails", "~> 5.0"
gem "rest-client", "~> 2.1"
gem "sidekiq", "~> 6.0"
gem "whenever", "~> 1.0", require: false

# Pagination
gem "bootstrap-kaminari-views", "~> 0.0"
gem "kaminari", "~> 1.2"

gem "counter_culture", "~> 2.3"

gem "pg_query", "~> 1.2"
gem "pghero", "~> 3.1"
gem "strong_migrations", "~> 0.6"

gem "oj", "~> 3.10"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", "~> 11.1", platform: :mri
  gem "pry-rails", "~> 0.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", "~> 2.1"
end

group :development do
  gem "better_errors", "~> 2.6"
  gem "binding_of_caller", "~> 0.8"
  gem "bullet", "~> 6.1"
  gem "magic_frozen_string_literal", "~> 1.1", require: false
  gem "rubocop", "~> 0.81", require: false
  gem "rubocop-rails", "~> 2.5", require: false
end
