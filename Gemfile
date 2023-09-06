source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails"
gem "pg"
gem "puma", "~> 4.1"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "bootsnap", ">= 1.4.2", require: false
gem "sidekiq"
gem "judoscale-ruby", github: "judoscale/judoscale-ruby", branch: "main", glob: "judoscale-ruby/*.gemspec"
gem "judoscale-rails", github: "judoscale/judoscale-ruby", branch: "main", glob: "judoscale-rails/*.gemspec"
gem "judoscale-sidekiq", github: "judoscale/judoscale-ruby", branch: "main", glob: "judoscale-sidekiq/*.gemspec"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "standardrb"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
