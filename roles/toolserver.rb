name('toolserver')

run_list([
  "recipe[jenkins]",
  "recipe[jenkins_perf]",
  "recipe[java::java_oracle_java7]"
])

override_attributes({
  :jenkins => {
      :tomcat => {
        :env => {
          "JAVA_OPTS": "-XX:MaxPermSize=256m -Xmx512m -Xms256m"
        }
      },
      :plugins => ["git", "git-client", "greenballs", "parameterized-trigger", "envinject","jenkins-multijob-plugin", "gatling"],
      :install_maven => true
    },
    :additional_packages =>[
      "uuid-runtime",
      "build-essential",
      "zlib1g-dev",
      "libssl-dev",
      "libreadline6-dev",
      "libxml2-dev",
      "libxslt-dev",
      "ncurses-dev",
      "libtool",
      "libldap2-dev",
      "dpkg-dev",
      "libdb4.8-dev",
      "libcrack2-dev",
      "make"
    ]
})