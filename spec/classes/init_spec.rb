require 'spec_helper'
describe 'arpwatch', type: 'class' do
    context 'On RedHat 7 with no parameters' do
        let (:facts) { { osfamily: 'RedHat', operatingsystemmajrelease: '7' } }
        it {
            should contain_package('arpwatch').with({'ensure'=>'installed'})
            should contain_file('/etc/sysconfig/arpwatch').with({'ensure'=>'file'})
        }
    end
    context 'On RedHat 6 with no parameters' do
        let (:facts) { { osfamily: 'RedHat', operatingsystemmajrelease: '6' } }
        it {
            should contain_package('arpwatch').with({'ensure'=>'installed'})
            should contain_file('/etc/sysconfig/arpwatch').with({'ensure'=>'file'})
        }
    end
    context 'On RedHat 5 with no parameters' do
        let (:facts) { { osfamily: 'RedHat', operatingsystemmajrelease: '6' } }
        it {
            should contain_package('arpwatch').with({'ensure'=>'installed'})
            should contain_file('/etc/sysconfig/arpwatch').with({'ensure'=>'file'})
        }
    end
    context 'On an unknown OS' do
        let :facts do
            {
                :osfamily => 'Darwin'
            }
        end
        it {
            expect { should raise_error(Puppet::Error) }
        }
    end
end
