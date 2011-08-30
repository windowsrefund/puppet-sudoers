# This definition creates a group entry via the sudoers type. 
# We use this in order to pull in the module's init.pp
#
define sudoers::group(ensure = 'present', $nopasswd = false, $commands) {

  include sudoers
  include sudoers::params

  sudoers ( $name:
    ensure => $ensure,
    isgroup => true,
    nopasswd => $nopasswd,
    commands => $commands,
    subscribe => Package[$sudoers::params::packages],
  }

}
