
name('base')

run_list([
  'recipe[base::system]',
  'recipe[master_chef::chef_solo_scripts]',
  'recipe[topology]',
  'recipe[topology::set_hostname]',
  'recipe[base::etc_hosts]',
  'recipe[lvm]'
])

override_attributes({
  :disable_ipv6 => true,
  :timezone => 'Europe/Paris',
  :ssh => {
    :allow_ssh_root_login => true
  },
  :bash_users => ['root', 'chef'],
  :ssh_keys => {
    :infra => {
      :users => ['root', 'chef'],
      :keys => [
        'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtIUTBrkzfyQ3z68AbzuF+mLJ0nij6L5/Ec1tBASdUr78MRyF6GIuDwDnzSz2HMaqjX7g3pqGd+i2nkugVbBi9S4N3RF7mW+7GA8wM3YPUaeJBTJb0yZqSuMzzwe+ByTwcCyraDEkoPTqZy5zsG2jaoPhnGourZwqlNn3EqMbhlszViHNxaVK2H1HxSr36Hi9tnFv/uQZGtUvFkS+ZN5OB/ooWVuqkqr1Fv5NkoyaY9ELVNFncfIAzxIKW/DIaYKciyBhL9bMYEtXEE9+Y1fFsbQcicGoiuhZeljGjHseJSX6zeP6M6d1RasqZAkmXkmeXUyEDuO0GIUb7SS5wibjNw== octo-mro@octo-mro-laptop',
        'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIBzxJPk3YcFRzo8khYTw4IKev2hwpdCvVCYWaoFb0QP5zkVdV4x8SiI1hbNJpkl/5VVSa5GpqOcdOajs7w+LL/bs8/rhtVTFacAKlN9M/B3H7ixX5vTe8aIid/7T+/A/xoedFPS2dCznKvRJuY1dwKxftPqRFjAIc7oYJtHKofQwQ== htr@octo',
        'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAqsfoo+k7q3Gs2UOJ70JywIzrwpna6NE6ZKz6D07e9S4qo3u1YMvuTpIQLHNrdYKKxoUBV9JgfJyDl9gT+rpq1Pk8h0pWrhy95BzYWF1+oHkYjAp8BVcjuAt2N8Ki+9N2uqJ3uSCbnxZGX0jQxQUBw/M3D8UwOhgoLIQ0n1VEcj6l2QE3dwwSo73O49Z3cfUtfZgNjXvVRJI0ivf8D7VJ5lbNseKDXWP3a6qmM3fdpOYeOFPw7GUSg1Yd8Sv0llQW2BLgmdYKnQtrm7q4YxQZAhsuRh1EXGbXBqv57LneGIQkIPx4YUkFbXCg+8l0uvdHbUHycMfIECT1Y3LXVqbFiw== mbo@OCTO-MBO'
      ]
    },
  }
})
