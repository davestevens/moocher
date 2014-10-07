source "https://rubygems.org"

gem "rails", "4.1.0"

gem "sass-rails", "~> 4.0.3"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.0.0"
gem "haml-rails"
gem "simple_form"
gem "bootstrap-sass"

gem "figaro"

gem "version"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "pry"
  gem "spring"
end

group :development, :test do
  gem "pry-rails"
  gem "guard-rspec", require: false
  gem "guard-bundler"
  gem "guard-rubocop"
  gem "teaspoon"

  gem "rubocop"
end

group :test do
  gem "rspec-rails"
  gem "shoulda-matchers", require: false
  gem "factory_girl_rails"
end
