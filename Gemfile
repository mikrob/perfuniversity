source 'http://rubygems.org'

gem 'capistrano'
gem 'capistrano_colors'
if ENV["DEV"]
  gem 'master-cap', :path => '/Users/mikael/developpement/infra/chef/master-cap'
else
  gem 'master-cap', :git => 'http://github.com/kitchenware/master-cap.git'
end
gem 'trollop'
gem 'foodcritic'
gem 'serverspec'
