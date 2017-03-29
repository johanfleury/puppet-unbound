# Class: unbound::params
class unbound::params {
  $package_name = 'unbound'
  $package_ensure = 'present'

  $service_name = 'unbound'
  $service_ensure = 'running'
  $service_enable = true

  $config_dir = '/etc/unbound'
  $config_file = "${config_dir}/unbound.conf"
  $config_sub_dir = '/etc/unbound/unbound.conf.d'

  $user = 'unbound'
  $group = 'unbound'

  $validate_cmd = 'unbound-checkconf %'

  $download_root_hints = true
  $download_trust_anchor = true

  $root_hints_url = 'https://www.internic.net/domain/named.cache'
}
