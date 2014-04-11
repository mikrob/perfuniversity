name('appserver')

run_list([
  'recipe[postgresql::server]',
  'recipe[dbserver]'
])

override_attributes({
  :postgresql => {
      :user_filters => ['0.0.0.0/32', '::1/128'],
      :listen_addresses => '0.0.0.0',
    }
})