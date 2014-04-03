
require 'bundler/setup'

set :git_repos_manager_class, 'SimpleGitReposManager'

set :autoload_runlist, true

set :git_repos, [
  {
    :url => "git://github.com/kitchenware/master-chef.git",
    :ref => "100a0e066ddad8465623caa0125bdd5088f05d33",
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