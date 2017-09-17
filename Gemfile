# source 'https://rubygems.org'

# gem 'solidus', github: 'solidusio/solidus'
# # Provides basic authentication functionality for testing parts of your engine
# gem 'solidus_auth_devise', '~> 1.0'

# gemspec


branch = ENV.fetch('SOLIDUS_BRANCH', 'v2.3')
gem "solidus", github: "solidusio/solidus", branch: branch
gem "solidus_auth_devise",  github: "solidusio/solidus_auth_devise", branch: 'master'

if branch == 'master' || branch >= "v2.0"
  gem "rails-controller-testing", group: :test
end

gem 'pg'
gem 'mysql2'

group :development, :test do
  gem "pry-rails"
end

gemspec
