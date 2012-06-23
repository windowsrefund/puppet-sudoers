class sudoers {

  include sudoers::params
  include sudoers::os

  package { $sudoers::params::packages:
	ensure => present,
  }
  realize Package[$sudoers::params::packages]

}
