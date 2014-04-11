name('toolserver')

run_list([
  "recipe[jenkins]",
  "recipe[jenkins_perf]",
  "recipe[java::java_oracle_java7]",
  "recipe[graphite]"
])

override_attributes({
  :jenkins => {
      :tomcat => {
        :env => {
          "JAVA_OPTS" => "-XX:MaxPermSize=256m -Xmx512m -Xms256m"
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
    ],
    :graphite => {
      :graphite => {
        :listen => "0.0.0.0:81"
      },
      :carbon => {
        :interface => "0.0.0.0",
        :port => 2003
      }
    },
    :ssh_keys => {
      :git => {
        :users => ['git'],
        :keys => [
          'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgErCuCXVyyylhjolgxu4NdzB1ziCXtgynPcXeDZH7VJ8KMD6hq2XFp6FPx2Rwj1c4Y3PuQuye7/uN/PErb3H+10UxldARqgiB4jtcQxJUNsLTxq+mxyVyf4xE1Q3tm0SqnURK4KemDVhdeiTFkp4xNX4PbExKVbgAN49buvuFuZf1IkzypSmI7LhnOwizka+6D0FoQpVLXTxkl20ylFhgbFGWhihgzroQPRpZPLAgWpHw6k7pmIu7LQrBNMCE2INeq87ijCusfJOFxxof2FicYyiEUNwKgzUgnYcp48eLGwyF/msVTiPe2b6JMTOR1h64wDgTEqixNbrhj7GcGgn/ tomcat@precise64',
          'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtIUTBrkzfyQ3z68AbzuF+mLJ0nij6L5/Ec1tBASdUr78MRyF6GIuDwDnzSz2HMaqjX7g3pqGd+i2nkugVbBi9S4N3RF7mW+7GA8wM3YPUaeJBTJb0yZqSuMzzwe+ByTwcCyraDEkoPTqZy5zsG2jaoPhnGourZwqlNn3EqMbhlszViHNxaVK2H1HxSr36Hi9tnFv/uQZGtUvFkS+ZN5OB/ooWVuqkqr1Fv5NkoyaY9ELVNFncfIAzxIKW/DIaYKciyBhL9bMYEtXEE9+Y1fFsbQcicGoiuhZeljGjHseJSX6zeP6M6d1RasqZAkmXkmeXUyEDuO0GIUb7SS5wibjNw== octo-mro@octo-mro-laptop',
          'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIBzxJPk3YcFRzo8khYTw4IKev2hwpdCvVCYWaoFb0QP5zkVdV4x8SiI1hbNJpkl/5VVSa5GpqOcdOajs7w+LL/bs8/rhtVTFacAKlN9M/B3H7ixX5vTe8aIid/7T+/A/xoedFPS2dCznKvRJuY1dwKxftPqRFjAIc7oYJtHKofQwQ== htr@octo',
          'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAqsfoo+k7q3Gs2UOJ70JywIzrwpna6NE6ZKz6D07e9S4qo3u1YMvuTpIQLHNrdYKKxoUBV9JgfJyDl9gT+rpq1Pk8h0pWrhy95BzYWF1+oHkYjAp8BVcjuAt2N8Ki+9N2uqJ3uSCbnxZGX0jQxQUBw/M3D8UwOhgoLIQ0n1VEcj6l2QE3dwwSo73O49Z3cfUtfZgNjXvVRJI0ivf8D7VJ5lbNseKDXWP3a6qmM3fdpOYeOFPw7GUSg1Yd8Sv0llQW2BLgmdYKnQtrm7q4YxQZAhsuRh1EXGbXBqv57LneGIQkIPx4YUkFbXCg+8l0uvdHbUHycMfIECT1Y3LXVqbFiw== mbo@OCTO-MBO',
          'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMTLbfAVcdGYFVvs3G3kYrd6QBY1HPAs2uTIRaqx0YbQtnWzsBtjBwNMbAyQTRtV8+xrWlAw7c310jt79CXrTkqa1xrxWhogMs//gchL5PbVI+EwTUgUSUKfri35Tv3Zxydx3Drs/clHATQN2v2Kyd398jL880PvLJFCKt0weKcTNy8cndefUL81jo8L11Ff/EQbeRCRAYmDDvNnzmXFLKI4QdP6s36hKROcvhH5GRbH+tJoqatn4RmexsfC38K9Kz8FaEpH3MAbZlYJ4HFbdjclsN8XeN5ONPqX/vHd8qXABDNf49Z4P9ld4cwYvdQog4yydRcTAjUWFw+F3OgHVFTtKBlLYfU3RHNjW755eQyh3ju7taf2h6O02n0k6CvK7wKndBLteRN7zXtc4YWBOlPY/TAUcobjNlX2hF98w+HVCPeEOzSXaoTaa7EvOGGjgvKkHAVUADjqO74hKmDtlfqu/llMItic4nK8H0bp/F1UYS7WCgwKoGqsyWHeYOfyUHynw9Q6Rxn06L2aP66Q1rddS/rYxvGW95Zm9f1AoxpTqkO/mniDoSy7Tjw2IYJIfrMAamADmC2kMCamt1Ocxl4aFS8Hb3NZ5/e1tO21VflcDAAHexoyjIARmBJkgu8XBwITru6WvFp534kpYuQaElrW47FqevTdqpIydybLd12w== ludovic@lpiot-hertzfeld.local'
        ]
      }
  }
})