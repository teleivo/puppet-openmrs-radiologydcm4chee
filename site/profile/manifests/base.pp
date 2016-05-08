# Profile for installing/configuring a baseline
class profile::base {

  contain 'profile::base::locales'
  contain 'profile::base::packages'
}

