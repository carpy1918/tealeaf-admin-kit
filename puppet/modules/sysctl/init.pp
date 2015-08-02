class sysctl::conf {

#include sysctl

file { "sysctl_conf":
  name => $operatingsystem ? {
  default => "/etc/sysctl.conf",
   },
}

 exec { "sysctl":
   command => "/sbin/sysctl -p",
   alias       => "sysctl",
   refreshonly => true,
   subscribe   => File["sysctl_conf"],
}

define sysctl::mod ( $key, $value ) {
# static variables set above
#  $key = 'net.ipv4.ip_forward'
#  $value = 1
  $context = "/files/etc/sysctl.conf"

 warning("sysctl::conf with $key and $value and $name")

 augeas { "$name":
   name => $name,
   context => "$context",
   onlyif  => "get $key != '$value'",
   changes => "set $key '$value'",
#     notify  => Exec["sysctl"],
  }
} #end sysctl::mod

sysctl::mod { 'mod1': 
  name => 'net.ipv4-mod1',
  key => 'net.ipv4.ip_forward',
  value => '1',
 }

sysctl::mod { 'mod2': 
  name => 'net.ipv4-mod2',
  key => 'net.ipv4.ip_forward',
  value => '0',
 }

} #end sysctl::conf

include sysctl::conf
