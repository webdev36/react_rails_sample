source 'https://rubygems.org'

# Rails project gems.
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Production server.
gem 'passenger'
gem 'pg'
gem 'rails_12factor', group: :production

# Project specific gems.
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap3-datetimepicker-rails'
gem 'chronic'
gem 'figaro'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'momentjs-rails'
gem 'pundit'
gem 'pundit-matchers', '~> 1.1.0'
gem 'rails_admin', '~> 1.0'
gem 'slim-rails'
gem 'stringex'
gem 'webpack-rails'
gem 'social-share-button'

# Authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

group :staging, :production do
  gem 'skylight'
end

group :development do
  gem 'letter_opener'
  gem 'rack-mini-profiler'

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

gem 'foreman'
