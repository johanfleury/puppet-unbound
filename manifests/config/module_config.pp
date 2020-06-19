# Class: unbound::config::module_config
class unbound::config::module_config {
  assert_private()

  $dns64_prefix = $unbound::dns64_prefix
  $dns64_synthall = $unbound::dns64_synthall

  if $dns64_prefix {
    file { "${unbound::config_sub_dir}/module-config.conf":
      ensure       => file,
      owner        => 'root',
      group        => $unbound::group,
      mode         => '0640',
      content      => template('unbound/module-config.conf.erb'),
      validate_cmd => $unbound::validate_cmd,
    }
  }
}
