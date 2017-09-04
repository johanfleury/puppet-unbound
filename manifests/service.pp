# Class: unbound::service
class unbound::service {
  assert_private()

  service { $::unbound::service_name:
    ensure => $::unbound::service_ensure,
    enable => $::unbound::service_enable,
  }
}
