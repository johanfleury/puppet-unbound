# Class: unbound::config::remote_control
class unbound::config::remote_control {
  assert_private()

  $control_enable = $::unbound::control_enable
  $control_interface = $::unbound::control_interface
  $control_port = $::unbound::control_port
  $control_use_cert = $::unbound::control_use_cert
  $server_key_file = $::unbound::server_key_file
  $server_key_content = $::unbound::server_key_content
  $server_key_source = $::unbound::server_key_source
  $server_cert_file = $::unbound::server_cert_file
  $server_cert_content = $::unbound::server_cert_content
  $server_cert_source = $::unbound::server_cert_source
  $control_key_file = $::unbound::control_key_file
  $control_key_content = $::unbound::control_key_content
  $control_key_source = $::unbound::control_key_source
  $control_cert_file = $::unbound::control_cert_file
  $control_cert_content = $::unbound::control_cert_content
  $control_cert_source = $::unbound::control_cert_source

  file { "${::unbound::config_sub_dir}/remote-control.conf":
    ensure       => file,
    owner        => 'root',
    group        => $::unbound::group,
    mode         => '0640',
    content      => template('unbound/remote-control.conf.erb'),
    validate_cmd => $::unbound::validate_cmd,
  }

  if $control_enable {
    if $control_use_cert or $control_use_cert == undef {
      if !($server_key_content or $server_key_source) {
        crit('No \'server_key_content\' nor \'server_key_source\' specified')
      } elsif ($server_key_content and $server_key_source) {
        fail("Can't use 'server_key_source' and 'server_key_content' at the same time.")
      }

      if !($server_cert_content or $server_cert_source) {
        crit('No \'server_cert_content\' nor \'server_cert_source\' specified')
      } elsif ($server_cert_content and $server_cert_source) {
        fail("Can't use 'server_cert_source' and 'server_cert_content' at the same time.")
      }

      if !($control_key_content or $control_key_source) {
        crit('No \'control_key_content\' nor \'control_key_source\' specified')
      } elsif ($control_key_content and $control_key_source) {
        fail("Can't use 'control_key_source' and 'control_key_content' at the same time.")
      }

      if !($control_cert_content or $control_cert_source) {
        crit('No \'control_cert_content\' nor \'control_cert_source\' specified')
      } elsif ($control_cert_content and $control_cert_source) {
        fail("Can't use 'control_cert_source' and 'control_cert_content' at the same time.")
      }

      file {
        default:
          ensure => file,
          owner  => 'root',
          group  => $::unbound::group,
          mode   => '0640',
          before => File["${unbound::config_sub_dir}/remote-control.conf"],
        ;
        $server_key_file:
          content => $server_key_content,
          source  => $server_key_source,
        ;
        $server_cert_file:
          content => $server_cert_content,
          source  => $server_cert_source,
        ;
        $control_key_file:
          content => $control_key_content,
          source  => $control_key_source,
        ;
        $control_cert_file:
          content => $control_cert_content,
          source  => $control_cert_source,
        ;
      }
    }
  } else {
    # ensure that the default key/cert files exist (and are empty), if we disable remote_commands
    # this is necessary to make unbound-checkconf (set with validate_cmd) happy since it checks the files
    # exists even if not used.
    $default_keyfiles = prefix(['unbound_server.key', 'unbound_server.pem', 'unbound_control.key', 'unbound_control.pem'], "${unbound::config_dir}/")
    file{ $default_keyfiles:
      ensure  => file,
      owner   => 'root',
      group   => $::unbound::group,
      mode    => '0640',
      content => '',
      before  => File["${unbound::config_sub_dir}/remote-control.conf"],
    }
  }
}
