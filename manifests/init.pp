#
# Install and configure arpwatch
#
# @example Basic installation and configuration of arpwatch
#   include ::arpwatch
#
# @example Install service and set it to send email alerts
#   class { 'arpwatch':
#     dest_email    => 'foo@bar.org',
#     source_email  => 'arpwatch@baz.com',
#   }
#
# @param config_file
#   The configuration file on the server to manage.
# @param config_template
#  The template to use when generating the config file
# @param dest_email
#  The email address to send arpwatch alerts to.
# @param interface
#   Which interface to watch for arp traffic
# @param opts
#   Additional command line options to pass to arpwatch at start
# @param package_ensure
#   Ensure value passed to the package resource
# @param package_name
#   Name of the package to manage
# @param service_enable
#   Enable value, passed to the service resource
# @param service_ensure
#   Ensure value, passed to the service resource
# @param service_name
#   Name of the service to manage
# @param service_user
#   Defines the user account that arpwatch will run under
# @param source_email
#   Define the source email address for arpwatch alerts (RedHat only)
#
class arpwatch (
  String  $package_name,
  String  $service_name,
  String  $config_file,
  String  $config_template,
  String  $interface,
  Variant[String,Array]
          $opts,
  String  $service_user,
  String  $dest_email                        = '-',
  String  $package_ensure                    = 'installed',
  Boolean $service_enable                    = true,
  Enum['running', 'stopped']
          $service_ensure                    = 'running',
  String  $source_email                      = "arpwatch@${::fqdn}",
  ) inherits arpwatch::params {
    validate_absolute_path($config_file)

    if ($::facts['osfamily'] !~ /^(Debian|RedHat)$/) {
      fail('Unsupported OS')
    }

    $_opts = any2array($opts)

    $epp_params = {
      interface    => $interface,
      service_user => $service_user,
      dest_email   => $dest_email,
      source_email => $source_email,
      opts         => $_opts,
    }

    package {$package_name:
      ensure => $package_ensure,
    }
    file {$config_file:
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp($config_template, $epp_params),
    }
    service {$service_name:
      ensure => $service_ensure,
      enable => $service_enable,
    }

    Package[$package_name]->File[$config_file]~>Service[$service_name]
}
