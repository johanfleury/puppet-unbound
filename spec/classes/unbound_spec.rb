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
      ).that_requires('Package[unbound]')
    }

    it {
      is_expected.to contain_file('/etc/unbound/unbound.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      ).that_requires('File[/etc/unbound]').that_notifies('Service[unbound]')
    }

    it {
      is_expected.to contain_file('/etc/unbound/unbound.conf.d').with(
        'ensure'  => 'directory',
        'purge'   => 'true',
        'recurse' => 'true',
        'owner'   => 'unbound',
        'group'   => 'unbound',
        'mode'    => '0750',
      ).that_requires('Package[unbound]')
    }

    it { is_expected.to contain_class('unbound::config::server')  }
    it { is_expected.to contain_class('unbound::config::remote_control')  }
    it { is_expected.to contain_class('unbound::config::module_config')  }
    it { is_expected.to contain_class('unbound::config::python')  }

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
      ).that_requires('File[/etc/unbound/unbound.conf.d]')
    }

    it { is_expected.not_to contain_exec('update-root-hints') }
    it { is_expected.not_to contain_exec('update-trust-anchors') }

    #
    # unbound::config::remote_control
    #

    it {
      is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/remote-control.conf').with(
        'ensure' => 'file',
        'owner'  => 'unbound',
        'group'  => 'unbound',
        'mode'   => '0640',
      ).that_requires('File[/etc/unbound/unbound.conf.d]')
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
      ).that_requires('File[/etc/unbound/unbound.conf.d]')
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
      ).that_requires('File[/etc/unbound/unbound.conf.d]')
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
