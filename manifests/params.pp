# Class: arpwatch::params
# ========================
class arpwatch::params {
    $package_name = 'arpwatch'
    $service_name = 'arpwatch'

  case $::osfamily {
    'RedHat': {
        $interface = 'eth0'
        $config_file = '/etc/sysconfig/arpwatch'
        $config_template = 'arpwatch/conf.rhel.erb'
        $opts = ''
        $service_user = $::operatingsystemmajrelease ? {
            '5' => 'pcap',
            default => 'arpwatch',
        }
    }
    'Debian': {
        $interface = 'eth0'
        $config_file = '/etc/default/arpwatch'
        $config_template = 'arpwatch/conf.deb.erb'
        $service_user = 'arpwatch'
        $opts = '-N -p'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} distribution.")
    }
  }
}
