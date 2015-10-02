# Role for installing/configuring PACS application
class role::pacs {

  contain 'profile::packages'
  contain 'profile::mysql'
  contain 'profile::java_oracle'
  contain 'profile::dcm4chee'

  Class['profile::packages']->
  Class['profile::mysql']->
  Class['profile::java_oracle']->
  Class['profile::dcm4chee']
}


