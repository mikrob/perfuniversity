name('appserver')

run_list([
  'recipe[tomcat]',
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
          "JAVA_OPTS" => "-XX:MaxPermSize=128m -Xmx512m -Xms128m -Dmetrics.graphite.enabled=true -Dmetrics.graphite.port=2003 -Dmetrics.graphite.host=192.168.56.11 -Dspring.profiles.active=\"postgresql\" -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8104 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false",
        }
    },

  },
  :postgresql => {
      :user_filters => ['0.0.0.0/32', '::1/128'],
      :listen_addresses => '0.0.0.0',
  },
  :ssh_keys => {
    :deploy => {
      :users => ['tomcat'],
      :keys => [
        'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgErCuCXVyyylhjolgxu4NdzB1ziCXtgynPcXeDZH7VJ8KMD6hq2XFp6FPx2Rwj1c4Y3PuQuye7/uN/PErb3H+10UxldARqgiB4jtcQxJUNsLTxq+mxyVyf4xE1Q3tm0SqnURK4KemDVhdeiTFkp4xNX4PbExKVbgAN49buvuFuZf1IkzypSmI7LhnOwizka+6D0FoQpVLXTxkl20ylFhgbFGWhihgzroQPRpZPLAgWpHw6k7pmIu7LQrBNMCE2INeq87ijCusfJOFxxof2FicYyiEUNwKgzUgnYcp48eLGwyF/msVTiPe2b6JMTOR1h64wDgTEqixNbrhj7GcGgn/ tomcat@precise64'
      ]
    }
  }
})