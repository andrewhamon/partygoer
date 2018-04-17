source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.5"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

gem "redis"
gem "sidekiq"

gem "rack-cors", require: "rack/cors"
gem "rspotify"

gem "graphql"
gem "twilio-ruby", "~> 4.1.0"

group :development, :test do
  gem "annotate"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara", "~> 2.13"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rubocop"
  gem "selenium-webdriver"
end

group :development do
  gem "graphiql-rails"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "rspec-rails"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
