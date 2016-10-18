# Class: arpwatch
# ===========================
#
# Install and configure arpwatch
#
# Parameters
# ----------
#
# * `config_file`
# The confiugration file on the server to manage.
#
# * `config_template`
# The template to use when generating the config file.
#
# * `dest_email`
# The email address to send arpwatch alerts to.
#
# * `interface`
# Which interface to watch for arp traffic
#
# * `package_ensure`
# Ensure value passed to the package resource
#
# * `package_name`
# Name of the package to manage
#
# * `service_enable`
# Enable value, passed to the service resource
#
# * `service_ensure`
# Ensure value, passed to the service resource
#
# * `service_name`
# Name of the service to manage
#
# * `service_user`
# Defines the user account that arpwatch will run under
#
# * `source_email`
# Define the source email address for arpwatch alerts
#
# Examples
# --------
#
# @example
#    class { 'arpwatch':
#      dest_email => 'foo@bar.org',
#      source_email => 'arpwatch@baz.com',
#    }
#
# Authors
# -------
#
# Ryan DeShone <rfdeshon@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Ryan DeShone, unless otherwise noted.
#
class arpwatch (
  $config_file = $arpwatch::params::config_file,
  $config_template = $arpwatch::params::config_template,
  $dest_email = '-',
  $interface = $arpwatch::params::interface,
  $package_ensure = 'installed',
  $package_name = $arpwatch::params::package_name,
  $service_enable = true,
  $service_ensure = 'running',
  $service_name = $arpwatch::params::service_name,
  $service_user = $arpwatch::params::service_user,
  $source_email = "arpwatch@${::fqdn}",
  ) inherits arpwatch::params {
    validate_string($dest_email)
    validate_string($package_name)
    validate_string($service_user)
    validate_string($service_name)
    validate_string($interface)
    validate_absolute_path($config_file)
    validate_string($package_ensure)
    validate_string($source_email)
    validate_bool($service_enable)
    validate_string($service_ensure)

    package {
      $package_name:
      ensure => $package_ensure,
    }
    file {
      $config_file:
      ensure  => 'file',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($config_template),
    }
    service {
      $service_name:
      ensure => $service_ensure,
      enable => $service_enable,
    }
    Package[$package_name]->File[$config_file]~>Service[$service_name]
}
