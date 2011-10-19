class sudoers {

  include sudoers::params
  include sudoers::os

  package { $sudoers::params::packages: }
  realize Package[$sudoers::params::packages]

}
