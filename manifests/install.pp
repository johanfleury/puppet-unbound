# Class: unbound::install
class unbound::install inherits unbound {
  assert_private()

  package { $unbound::package_name:
    ensure => $unbound::package_ensure,
  }
}
