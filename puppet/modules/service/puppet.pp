#
# enable service and verify running status
#

case $operatingsystem {
  centos, redhat: { $service_name = 'puppet' }
  debian, ubuntu: { $service_name = 'puppet' }
}

package { 'puppet':
  ensure => installed
}

package { 'puppet-server':
  ensure => installed
}

service { 'puppet':
  name      => $service_name,
  ensure    => running,
  enable    => true,
  subscribe => File['puppet.conf'],
}

file { 'puppet.conf':
  path    => '/etc/puppet/puppet.conf',
  ensure  => file,
  require => Package['puppet', 'puppet-server'],
  source  => "puppet:///modules/service/puppet.conf",
}
