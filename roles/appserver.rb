name('appserver')

run_list([
  'recipe[tomcat]',
  'recipe[postgresql::server]',
  'recipe[appserver]'
])

override_attributes({
  :happystore => {
    :tomcat  => {
        :name => "happystore",
        :connectors => {
          :http => {
            :address => "0.0.0.0",
            :port => 8080
          }
        },
        :env => {
          "JAVA_OPTS" => "-XX:MaxPermSize=128m -Xmx512m -Xms128m -Dmetrics.graphite.enabled=true -Dmetrics.graphite.port=2003 -Dmetrics.graphite.host=192.168.56.11 -Dspring.profiles.active=\"postgresql\"",
        }
    },

  },
  :postgresql => {
      :user_filters => ['0.0.0.0/32', '::1/128'],
      :listen_addresses => '0.0.0.0',
    }
})