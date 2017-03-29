# Defined type: unbound::view
define unbound::view (
  Optional[Array[String]] $local_zone = undef,
  Optional[Array[String]] $local_data = undef,
  Optional[Boolean] $stub_prime = undef,
) {
  ensure_resource('concat', "${unbound::config_subdir}/views.conf", {
    ensure       => present,
    owner        => $unbound::user,
    group        => $unbound::group,
    mode         => '0640',
    warn         => true,
    require      => File[$unbound::config_dir],
    notify       => Service[$unbound::params::service_name],
    validate_cmd => $unbound::validate_cmd,
  })

  concat::fragment { "view-${title}.conf":
    target  => "${unbound::config_subdir}/views.conf",
    content => template('unbound/view.conf.erb'),
  }
}
