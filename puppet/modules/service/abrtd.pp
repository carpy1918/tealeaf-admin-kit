#
# enable service and verify running status
#

case $operatingsystem {
  centos, redhat: { $service_name = 'abrtd' }
  debian, ubuntu: { $service_name = 'abrtd' }
}

abrt
abrt-addon-kerneloops
abrt-addon-python
abrt-libs
abrt-tui
abrt-cli
abrt-addon-ccpp

package { 'abrt':
  ensure => installed
}

package { 'abrt-libs':
  ensure => installed
}

package { 'abrt-tui':
  ensure => installed
}

package { 'abrt-cli':
  ensure => installed
}

package { 'abrt-addon-ccpp':
  ensure => installed
}

service { 'abrtd':
  name      => $service_name,
  ensure    => running,
  enable    => true,
  subscribe => File['abrt.conf'],
}

file { '':
  path    => '/etc/abrt/abrt.conf',
  ensure  => file,
  require => Package['abrt', 'abrt-libs'],
  source  => "puppet:///modules/service/abrt.conf",
}
