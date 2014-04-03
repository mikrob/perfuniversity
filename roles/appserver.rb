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
          "JAVA_OPTS" => "-XX:MaxPermSize=128m -Xmx512m -Xms128m"
        }
    },
  }
})