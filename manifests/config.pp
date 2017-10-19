# Class: unbound::config
class unbound::config {
  assert_private()

  file { $unbound::config_dir:
    ensure  => directory,
    purge   => true,
    recurse => true,
    owner   => $unbound::user,
    group   => $unbound::group,
    mode    => '0750',
    require => Package[$unbound::package_name],
  }

  file { $unbound::config_file:
    ensure  => file,
    owner   => $unbound::user,
    group   => $unbound::group,
    mode    => '0640',
    content => template('unbound/unbound.conf.erb'),
    require => File[$unbound::config_dir],
    notify  => Service[$unbound::service_name],
  }

  $config_sub_dir = $unbound::config_sub_dir

  file { $config_sub_dir:
    ensure  => directory,
    purge   => true,
    recurse => true,
    owner   => $unbound::user,
    group   => $unbound::group,
    mode    => '0750',
    require => File[$unbound::config_dir],
  }

  contain ::unbound::config::server
  contain ::unbound::config::remote_control
  contain ::unbound::config::module_config
  contain ::unbound::config::python

  create_resources('::unbound::stub_zone', $unbound::stub_zones)
  create_resources('::unbound::forward_zone', $unbound::forward_zones)
  create_resources('::unbound::view', $unbound::views)
}
