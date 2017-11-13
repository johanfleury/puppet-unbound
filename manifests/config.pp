# Class: unbound::config
class unbound::config {
  assert_private()

  $config_sub_dir = $unbound::config_sub_dir

  file { $unbound::config_dir:
    ensure  => directory,
    purge   => true,
    recurse => true,
    owner   => $unbound::user,
    group   => $unbound::group,
    mode    => '0750',
  }

  file { $unbound::config_file:
    ensure  => file,
    owner   => $unbound::user,
    group   => $unbound::group,
    mode    => '0640',
    content => template('unbound/unbound.conf.erb'),
  }

  file { $config_sub_dir:
    ensure  => directory,
    purge   => true,
    recurse => true,
    owner   => $unbound::user,
    group   => $unbound::group,
    mode    => '0750',
  }

  contain ::unbound::config::server
  contain ::unbound::config::remote_control
  contain ::unbound::config::module_config
  contain ::unbound::config::python

  create_resources('::unbound::stub_zone', $unbound::stub_zones)
  create_resources('::unbound::forward_zone', $unbound::forward_zones)
  create_resources('::unbound::view', $unbound::views)
}
