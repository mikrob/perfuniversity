base_user node.tomcat.user

warp_install "tomcat" do
  rbenv true
end

file "#{get_home node.tomcat.user}/.gitconfig" do
  mode '0644'
  owner node.tomcat.user
  content <<-EOF
  [user]
  name = Jenkins
  email = jenkins@localhost.com
  EOF
end

# we set maven to use storage offline proxy
template "#{node.maven.home}/apache-maven-#{node.maven.version}/conf/settings.xml" do
    owner node.tomcat.user
    group node.tomcat.user
    source "maven_settings.xml.erb"
end

# jenkins configuration (add jdk7 for example)

["config.xml", "hudson.tasks.Shell.xml"].each do |x|
  template "#{node.jenkins.home}/#{x}" do
    owner node.tomcat.user
    group node.tomcat.user
    source "#{x}.erb"
    notifies :restart, resources(:service => "jenkins")
  end
end

# say ok to storage ssh key for user tomcat
ssh_accept_host_key "git@bitbucket.org" do
  user node.tomcat.user
end

directory "#{node.jenkins.home}/jobs" do
   owner node.tomcat.user
end

#create jobs in jenkins
=begin
["build_happystore", "deploy_happystore", "gatling_build"].each do |x|
  directory "#{node.jenkins.home}/jobs/#{x}" do
    owner node.tomcat.user
  end

  template "#{node.jenkins.home}/jobs/#{x}/config.xml" do
    owner node.tomcat.user
    source "jobs/#{x}.xml.erb"
    notifies :restart, resources(:service => "jenkins")
  end

end
=end

ssh_key_private node.tomcat.user

file "#{node.jenkins.home}/ssh_agent.sh" do
  mode '0755'
  owner node.tomcat.user
  content <<-EOF
#!/bin/sh -e

ssh-agent /bin/sh -c "ssh-add && $*"
EOF
end

base_user "git"

ssh_key_private "git"

service "ssh" do
  supports :restart => true
  action auto_compute_action
end

# say ok to storage ssh key for user tomcat
ssh_accept_host_key "git@bitbucket.org" do
  user "git"
end

git_clone "/home/git/perfuniversity" do
  user "git"
  repository "git@bitbucket.org:henri_tremblay/perfuniversity.git"
  reference "master"
end