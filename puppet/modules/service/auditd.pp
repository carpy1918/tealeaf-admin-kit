#
# enable service and verify running status
#

case $operatingsystem {
  centos, redhat: { $service_name = 'auditd' }
  debian, ubuntu: { $service_name = 'auditd' }
}

package { 'audit':
  ensure => installed
}

package { 'audit-libs':
  ensure => installed
}

package { 'audit-libs-python':
  ensure => installed
}

service { 'auditd':
  name      => $service_name,
  ensure    => running,
  enable    => true,
  subscribe => File['auditd.conf', 'audit.rules'],
}

file { 'auditd.conf':
  path    => '/etc/audit/auditd.conf',
  ensure  => file,
  require => Package['audit', 'audit-libs', 'audit-libs-python'],
  source  => "puppet:///modules/service/auditd.conf",
}

file { 'audit.rules':
  path    => '/etc/audit/audit.rules',
  ensure  => file,
  require => Package['audit', 'audit-libs', 'audit-libs-python'],
  source  => "puppet:///modules/service/audit.rules",
}

