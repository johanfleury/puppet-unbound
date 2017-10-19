# Class: unbound::install
class unbound::install {
  assert_private()

  package { $::unbound::package_name:
    ensure => $::unbound::package_ensure,
  }
}
