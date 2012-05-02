# OS-specific resources and overrides
#
class sudoers::os inherits sudoers {

  include sudoers::params

  case $::operatingsystem {

    solaris: {

      # Only remove if OpenCSW's package is installed
      package { SUNWsudo:
        ensure => absent,
        require => Package[$sudoers::params::packages],
        provider => sun,
      }

      # Manage a symlink only after SUN's sudo is uninstalled
      file {
        '/usr/bin/sudo':
          ensure => '/opt/csw/bin/sudo.minimal',
          require => Package[SUNWsudo];
        '/etc/sudoers':
          ensure => absent,
          require => File[$sudoers::params::sudoers];
      }

    }

  }

	

}
