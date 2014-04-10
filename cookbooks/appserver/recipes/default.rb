target_war = tomcat_instance "happystore:tomcat" do
  war_location "/happystore"
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

postgresql_database "happystore:database"