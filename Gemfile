source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Core
ruby '2.5.3'
gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 3.11'

# Front End
gem 'sass-rails', '~> 5.0'
gem "haml-rails", "~> 1.0"
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'mini_magick', '~> 4.8'

# API
gem 'jbuilder', '~> 2.5'

# Background Processing
gem 'redis', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
