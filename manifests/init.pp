class sudoers {

  include sudoers::params
  include sudoers::os

  # Virtual package resources are defined in a seperate 'packages' module
  include packages
  realize(Package[$sudoers::params::packages])

}
