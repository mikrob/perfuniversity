
require 'bundler/setup'

set :git_repos_manager_class, 'SimpleGitReposManager'

set :autoload_runlist, true

set :git_repos, [
  {
    :url => "git://github.com/kitchenware/master-chef.git",
    :ref => "6decb078c15a4b170cdf0c3e264b1d2c4e5e4a89",
  },
  {
    :url => "git://github.com/kitchenware/master-cap.git",
    :local_path => "../master-cap",
  },
  {
    :url => "git@bitbucket.org:henri_tremblay/perfuniversity.git",
    :local_path => "../perfuniversity",
  },
]

require 'master-cap'
require 'master-cap/apps'