# Class: unbound::service
class unbound::service inherits unbound {
  assert_private()

  service { $unbound::service_name:
    ensure  => $unbound::service_ensure,
    enable  => $unbound::service_enable,
    require => File[$unbound::config_file],
  }
}
