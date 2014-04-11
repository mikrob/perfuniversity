target_war = tomcat_instance "happystore:tomcat" do
  war_location "/happystore"
end

add_apt_repository "ppa_collectd5_precise" do
 url "http://ppa.launchpad.net/bpaquet/collectd5-precise/ubuntu"
 key "C4832F92"
 key_server "keyserver.ubuntu.com"
end

include_recipe "collectd"

collectd_plugin "write_graphite" do
 config <<-EOF
<Carbon>
        Host "192.168.56.11"
        Port "2003"
</Carbon>
EOF
end


