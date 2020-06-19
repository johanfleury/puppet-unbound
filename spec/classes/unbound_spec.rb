# frozen_string_literal: true

require 'spec_helper'

describe 'unbound' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it do
        is_expected.to compile.with_all_deps

        is_expected.to contain_class('unbound')
      end

      context 'with default parameters' do
        #
        # unbound::install
        #
        it do
          is_expected.to contain_class('unbound::install')

          is_expected.to contain_package('unbound').only_with_ensure('installed')
        end

        #
        # unbound::config
        #
        it do
          is_expected.to contain_class('unbound::config')

          is_expected.to contain_file('/etc/unbound').only_with(
            'ensure'  => 'directory',
            'purge'   => 'true',
            'recurse' => 'true',
            'owner'   => 'root',
            'group'   => 'unbound',
            'mode'    => '0750',
          )

          is_expected.to contain_file('/etc/unbound/unbound.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          is_expected.to contain_file('/etc/unbound/unbound.conf.d').only_with(
            'ensure'  => 'directory',
            'purge'   => 'true',
            'recurse' => 'true',
            'owner'   => 'root',
            'group'   => 'unbound',
            'mode'    => '0750',
          )

          is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/stub-zones.conf')
          is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/forward-zones.conf')
          is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/views.conf')

          #
          # unbound::config::server
          #
          is_expected.to contain_class('unbound::config::server')

          is_expected.to contain_file('/etc/unbound/unbound.conf.d/server.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          is_expected.not_to contain_exec('update-root-hints')
          is_expected.not_to contain_exec('update-trust-anchors')

          #
          # unbound::config::remote_control
          #
          is_expected.to contain_class('unbound::config::remote_control')

          is_expected.to contain_file('/etc/unbound/unbound.conf.d/remote-control.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          is_expected.to contain_file('/etc/unbound/unbound_control.key').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          is_expected.to contain_file('/etc/unbound/unbound_control.pem').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          is_expected.to contain_file('/etc/unbound/unbound_server.key').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          is_expected.to contain_file('/etc/unbound/unbound_server.pem').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          #
          # unbound::config::module_config
          #
          is_expected.to contain_class('unbound::config::module_config')

          is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/module-config.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )

          #
          # unbound::config::python
          #
          is_expected.to contain_class('unbound::config::python')

          is_expected.not_to contain_file('/etc/unbound/unbound.conf.d/python.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'unbound',
            'mode'   => '0640',
          )
        end

        #
        # unbound::service
        #
        it do
          is_expected.to contain_class('unbound::service')

          is_expected.to contain_service('unbound').only_with(
            'ensure' => 'running',
            'enable' => true,
          )
        end
      end
    end
  end
end
