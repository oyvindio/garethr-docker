require 'spec_helper'

describe 'docker::service', :type => :class do
[
  { :osfamily => 'Debian', :operatingsystem => 'Debian', :operatingsystemmajrelease => '8' },
  { :osfamily => 'Debian', :operatingsystem => 'Ubuntu', :operatingsystemrelease => '15.04' },
  { :osfamily => 'Archlinux' },
].each do |facts|

  context "on #{facts.inspect}" do

    let(:facts) { facts }

      context 'It should set extra_systemd_parameter in service-overrides.conf' do
        let(:params) { {
          :extra_systemd_parameters => { 'EnvironmentFile' => '/foo/bar' }
        } }
        it { should contain_file('/etc/systemd/system/docker.service.d/service-overrides.conf').with_content(/EnvironmentFile=\/foo\/bar/) }
      end

      context 'It should set multiple extra_systemd_parameters in service-overrides.conf' do
        let(:params) { {
          :extra_systemd_parameters => { 'EnvironmentFile' => '/foo/bar', 'After' => 'flanneld' }
        } }
        it { should contain_file('/etc/systemd/system/docker.service.d/service-overrides.conf').with_content(/EnvironmentFile=\/foo\/bar/) }
        it { should contain_file('/etc/systemd/system/docker.service.d/service-overrides.conf').with_content(/After=flanneld/) }
    end
    end
  end
end
