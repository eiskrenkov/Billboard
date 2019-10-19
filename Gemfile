source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Core
gem 'rails', '~> 6.0.0'
gem 'puma', '~> 3.11'
gem 'mysql2', '>= 0.4.4'
gem 'devise'
gem 'simple_form'
gem 'enumerate_it'
gem 'inherited_resources'

# Frontend
gem 'webpacker', '~> 4.0'
gem 'sass-rails', '~> 5'
gem 'slim-rails'

# Others
gem 'bootsnap', '>= 1.4.2', require: false
gem 'aws-sdk-s3', require: false

group :development do
  gem 'better_errors'
  gem 'annotate'

  gem 'byebug'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Code analysis
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-thread_safety', require: false
  gem 'rubocop-rspec', require: false

  gem 'pronto-rubocop', require: false
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot'
end
