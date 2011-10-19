class sudoers::params {
  
  case $operatingsystem {
    debian, ubuntu: {
      $packages = 'sudo'
    }

    solaris: {
	    $packages = [ 'libiconv', 'libpopt', 'alternatives', 'sudo_common', 'sudo' ]
    }

    default: {
        fail("The sudoers module is not supported on $operatingsystem")
    }

  }

}
