# Class: arpwatch::params
# ========================
class arpwatch::params {
  case $::osfamily {
    'RedHat': {
    $package_name = 'arpwatch'
    $service_name = 'arpwatch'
    $interface = 'eth0'
    $config_file = '/etc/sysconfig/arpwatch'
    $config_template = 'arpwatch/conf.rhel.erb'
    $service_user = $::operatingsystemmajrelease ? {
        '5' => 'pcap',
        default => 'arpwatch',
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} distribution.")
    }
  }
}
