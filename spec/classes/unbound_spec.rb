require 'spec_helper'

describe 'unbound' do
  context 'with defaults for all parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('unbound') }
    it { is_expected.to contain_class('unbound::params') }
    it { is_expected.to contain_class('unbound::install') }
    it { is_expected.to contain_class('unbound::config') }
    it { is_expected.to contain_class('unbound::service') }

    #
    # unbound::install
    #

    it { is_expected.to contain_package('unbound').with('ensure' => 'present') }

    #
    # unbound::config
    #

    it {
      is_expected.to contain_file('/etc/unbound').with(
        'ensure'  => 'directory',
        'purge'   => 'true',
        'recurse' => 'true',
        'owner'   => 'unbound',
        'group'   => 'unbound',
        'mode'    => '0750',
      )
    }

    it {
      is_expected.to contain_file('/etc/unbound/unbound.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }

    it {
      is_expected.to contain_file('/etc/unbound/unbound.conf.d').with(
        'ensure'  => 'directory',
        'purge'   => 'true',
        'recurse' => 'true',
        'owner'   => 'unbound',
        'group'   => 'unbound',
        'mode'    => '0750',
      )
    }

    it { is_expected.to contain_class('unbound::config::server') }
    it { is_expected.to contain_class('unbound::config::remote_control') }
    it { is_expected.to contain_class('unbound::config::module_config') }
    it { is_expected.to contain_class('unbound::config::python') }

    it { is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/stub-zones.conf') }
    it { is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/forward-zones.conf') }
    it { is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/views.conf') }

    #
    # unbound::config::server
    #

    it {
      is_expected.to contain_file('/etc/unbound/unbound.conf.d/server.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }

    it { is_expected.not_to contain_exec('update-root-hints') }
    it { is_expected.not_to contain_exec('update-trust-anchors') }

    #
    # unbound::config::remote_control
    #

    it {
      is_expected.to contain_file('/etc/unbound/unbound.conf.d/remote-control.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }

    it {
      is_expected.to contain_file('/etc/unbound/unbound_control.key').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }
    it {
      is_expected.to contain_file('/etc/unbound/unbound_control.pem').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }
    it {
      is_expected.to contain_file('/etc/unbound/unbound_server.key').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }
    it {
      is_expected.to contain_file('/etc/unbound/unbound_server.pem').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }

    #
    # unbound::config::module_config
    #

    it {
      is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/module-config.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }

    #
    # unbound::config::python
    #

    it {
      is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/python.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      )
    }

    #
    # unbound::service
    #

    it {
      is_expected.to contain_service('unbound').with(
        'ensure' => 'running',
        'enable' => true,
      )
    }
  end
end
