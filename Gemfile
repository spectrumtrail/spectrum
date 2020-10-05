source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Core
ruby "2.5.3"
gem "rails", "~> 5.2.2"
gem "pg", ">= 0.18", "< 2.0"
gem "bootsnap", ">= 1.4.3", require: false
gem "puma", "~> 4.3"
gem "devise"
gem "barnes"
gem "airbrake", '~> 9.5'
gem 'ranked-model'

# Parsing
gem "redcarpet", "~> 3.5"

# Asset Storage
gem "aws-sdk-s3", require: false
gem 'mini_magick', '~> 4.9'

# Front End
gem "draper"
gem 'bootstrap-select-rails'
gem "sass-rails", "~> 5.0"
gem "haml-rails", "~> 1.0"
gem "coffee-rails", "~> 4.2"
gem "local_time"
gem "uglifier"
gem 'friendly_id', '~> 5.2.4'
gem "simple_form"
gem "client_side_validations"
gem "client_side_validations-simple_form"
gem "gon"
gem "wicked"
gem "kaminari"
gem "chartkick"

# ActiveRecord Enhancements
gem 'by_star', git: "git://github.com/radar/by_star"
gem 'groupdate'
gem 'ransack'

# email delivery
gem "ahoy_email"
gem "premailer-rails"
gem "sendgrid-ruby"
gem "sendgrid-actionmailer"

# payments
gem "stripe"

# Background Processing
gem "redis", "~> 4.0"
gem "sidekiq"

# Performance Monitoring
gem 'scout_apm'

# Built-in Analytics
gem 'ahoy_matey'

# Ecommerce Tracking
gem 'rack-tracker'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', groups: [:development, :test]
  gem 'factory_bot_rails'
  gem "rspec"
  gem "rspec-rails", "~> 3.8"
end

group :development do
  gem "bullet"
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
