# Defined type: unbound::view
define unbound::view (
  Optional[Array[String]] $local_zone = undef,
  Optional[Array[String]] $local_data = undef,
  Optional[Boolean] $stub_prime = undef,
) {

  ensure_resource('::concat', "${::unbound::config_sub_dir}/views.conf", {
    ensure       => present,
    owner        => 'root',
    group        => $::unbound::group,
    mode         => '0640',
    warn         => true,
    validate_cmd => $::unbound::validate_cmd,
  })

  ::concat::fragment { "view-${title}.conf":
    target  => "${::unbound::config_sub_dir}/views.conf",
    content => template('unbound/view.conf.erb'),
  }
}
