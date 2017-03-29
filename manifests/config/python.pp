# Class: unbound::config::python
class unbound::config::python inherits unbound {
  assert_private()

  $python_script = $unbound::python_script

  if $python_script {
    file { "${unbound::config_sub_dir}/python.conf":
      ensure       => file,
      owner        => $unbound::user,
      group        => $unbound::group,
      mode         => '0640',
      content      => template('unbound/python.erb'),
      require      => File[$unbound::config_sub_dir],
      notify       => Service[$unbound::params::service_name],
      validate_cmd => $unbound::validate_cmd,
    }
  }
}
