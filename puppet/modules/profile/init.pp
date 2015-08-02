#
# Profile module to manage the files in a home directory
#

case $operatingsystem {
centos, redhat: { $home = "/home" }
debian, ubuntu: { $home = "/home" }
solaris: { $home = "/export/home" }
}

class profile {

notice("owner profile configuration started. home = $home. os = $operatingsystem. date = $datestr")

$u = "curt"
file { "bashrc-$u" : 
  ensure => file,
  backup => true,
  checksum => "md5",
  mode => "0640",
  owner => "$u",
  group => "$u",
  path => "$home/$u/.bashrc",
  source => "puppet:///modules/profile/bashrc-$u"
}
file { "bash_profile-$u" : 
  ensure => file,
  backup => true,
  checksum => "md5",
  mode => "0640",
  owner => "$u",
  group => "$u",
  path => "$home/$u/.bash_profile",
  source => "puppet:///modules/profile/bash_profile-$u"
}
file { "vimrc-$u" : 
  ensure => file,
  backup => true,
  checksum => "md5",
  mode => "0640",
  owner => "$u",
  group => "$u",
  path => "$home/$u/.vimrc",
  source => "puppet:///modules/profile/vimrc-$u"
}
file { "authorized_keys-$u" : 
  ensure => file,
  backup => true,
  checksum => "md5",
  mode => "0640",
  owner => "$u",
  group => "$u",
  path => "$home/$u/.ssh/authorized_keys",
  source => "puppet:///modules/profile/authorized_keys-$u"
}

file { "id-dsa-pub-$u" : 
  ensure => file,
  backup => true,
  checksum => "md5",
  mode => "0640",
  owner => "$u",
  group => "$u",
  path => "$home/$u/.ssh/id_dsa.pub",
  source => "puppet:///modules/profile/id_dsa.pub-$u"
}
file { "id_dsa-$u" : 
  ensure => file,
  backup => true,
  checksum => "md5",
  mode => "0640",
  owner => "$u",
  group => "$u",
  path => "$home/$u/.ssh/id_dsa",
  source => "puppet:///modules/profile/id_dsa-$u"
}

notice("owner profile configuration complete")

}

include profile
