# Defined type: unbound::forward_zone
define unbound::forward_zone (
  Optional[Array[String]] $forward_host = undef,
  Optional[Array[String]] $forward_addr = undef,
  Optional[Boolean] $forward_prime = undef,
  Optional[Boolean] $forward_first = undef,
  Optional[Boolean] $forward_ssl_upstream = undef,
) {
  if !($forward_host or $forward_addr) {
    fail('You must provide forward_host or forward_addr')
  }

  ensure_resource('::concat', "${::unbound::config_sub_dir}/forward-zones.conf", {
    ensure       => present,
    owner        => $::unbound::user,
    group        => $::unbound::group,
    mode         => '0640',
    warn         => true,
    validate_cmd => $::unbound::validate_cmd,
  })

  ::concat::fragment { "forward-${title}":
    target  => "${::unbound::config_sub_dir}/forward-zones.conf",
    content => template('unbound/forward-zone.conf.erb'),
  }
}
