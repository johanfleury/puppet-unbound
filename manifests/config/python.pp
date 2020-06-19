# Class: unbound::config::python
class unbound::config::python {
  assert_private()

  $python_script = $unbound::python_script

  if $python_script {
    file { "${unbound::config_sub_dir}/python.conf":
      ensure       => file,
      owner        => 'root',
      group        => $unbound::group,
      mode         => '0640',
      content      => template('unbound/python.erb'),
      validate_cmd => $unbound::validate_cmd,
    }
  }
}
