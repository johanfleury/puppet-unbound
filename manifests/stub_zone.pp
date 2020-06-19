# Defined type: unbound::stub_zones
define unbound::stub_zone (
  Optional[Array[String]] $stub_host = undef,
  Optional[Array[String]] $stub_addr = undef,
  Optional[Boolean] $stub_prime = undef,
  Optional[Boolean] $stub_first = undef,
  Optional[Boolean] $stub_ssl_upstream = undef,
) {
  if !($stub_host or $stub_addr) {
    fail('You must provide stub_host or stub_addr')
  }

  ensure_resource('::concat', "${::unbound::config_sub_dir}/stub-zones.conf", {
    ensure       => present,
    owner        => 'root',
    group        => $::unbound::group,
    mode         => '0640',
    warn         => true,
    validate_cmd => $::unbound::validate_cmd,
  })

  ::concat::fragment { "stub-${title}":
    target  => "${::unbound::config_sub_dir}/stub-zones.conf",
    content => template('unbound/stub-zone.conf.erb'),
  }
}
