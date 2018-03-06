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

gem "coffee-rails", "~> 4.2"
gem "jbuilder", "~> 2.5"

gem "rack-cors", require: "rack/cors"
gem "rspotify"

group :development, :test do
  gem "annotate"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "capybara", "~> 2.13"
  gem "dotenv-rails"
  gem "rubocop"
  gem "selenium-webdriver"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
