class sysctl::conf {

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
  key => 'net.ipv4.ip forward',
  value => '0',
 }

sysctl::mod { 'mod2': 
  name => 'net.ipv4-mod2',
  key => 'net.ipv4.conf.all.send redirects',
  value => '0',
 }

sysctl::mod { 'mod3': 
  name => 'net.ipv4-mod3',
  key => 'net.ipv4.conf.default.send redirects',
  value => '0',
 }

sysctl::mod { 'mod4': 
  name => 'net.ipv4-mod4',
  key => 'net.ipv4.conf.all.secure_redirects',
  value => '0',
 }

 sysctl::mod { 'mod5':
   name => 'net.ipv4-mod5',
   key => 'net.ipv4.conf.default.accept_redirects',
   value => '0',
  }

 sysctl::mod { 'mod6':
   name => 'net.ipv4-mod6',
   key => 'net.ipv4.icmp_ignore_bogus_error_messages',
   value => '1',
  }

 sysctl::mod { 'mod7':
   name => 'net.ipv4-mod7',
   key => 'net.ipv4.conf.all.accept_source_route',
   value => '0',
  }

 sysctl::mod { 'mod8':
   name => 'net.ipv4-mod8',
   key => 'net.ipv4.tcp_syncookies',
   value => '1',
  }

 sysctl::mod { 'mod9':
   name => 'net.ipv4-mod9',
   key => 'net.ipv4.icmp_echo_ignore_broadcasts',
   value => '1',
  }

 sysctl::mod { 'mod10':
   name => 'net.ipv4-mod10',
   key => 'net.ipv4.icmp_ignore_bogus_error_responses',
   value => '1',
  }

 sysctl::mod { 'mod11':
   name => 'net.ipv4-mod11',
   key => 'net.ipv4.conf.all.log_martians',
   value => '1',
  }

 sysctl::mod { 'mod12':
   name => 'net.ipv4-mod4',
   key => 'net.ipv4.conf.default.log_martians',
   value => '1',
  }

 sysctl::mod { 'mod13':
   name => 'net.ipv4-mod13',
   key => 'net.ipv4.conf.all.accept_source_route',
   value => '0',
  }

 sysctl::mod { 'mod14':
   name => 'net.ipv4-mod14',
   key => 'net.ipv4.conf.default.accept_source_route',
   value => '0',
  }

 sysctl::mod { 'mod15':
   name => 'net.ipv4-mod15',
   key => 'net.ipv4.conf.all.accept_redirects',
   value => '0',
  }

 sysctl::mod { 'mod16':
   name => 'net.ipv4-mod15',
   key => 'net.ipv4.conf.default.accept_redirects',
   value => '0',
  }

 sysctl::mod { 'mod17':
   name => 'net.ipv4-mod17',
   key => 'net.ipv4.conf.all.secure_redirects',
   value => '0',
  }

 sysctl::mod { 'mod18':
   name => 'net.ipv4-mod18',
   key => 'net.ipv4.conf.default.secure_redirects',
   value => '0',
  }

} #end sysctl::conf

include sysctl::conf
