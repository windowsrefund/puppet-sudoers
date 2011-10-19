class sudoers {

  include sudoers::params
  include sudoers::os

  realize(Package[$sudoers::params::packages])
  realize Package[$sudoers::params::packages]

}
