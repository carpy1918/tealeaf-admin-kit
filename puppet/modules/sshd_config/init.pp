class sshd_config::conf {

file { "sshd_config":
  name => $operatingsystem ? {
  default => "/etc/ssh/sshd_config",
   },
}

 exec { "sshdconfig":
   command => "/etc/init.d/sshd reload",
   alias       => "sshdconfig",
   refreshonly => true,
   subscribe   => File["sshd_config"],
}

define sshd_config::mod ( $key, $value ) {
 $context = "/files/etc/ssh/sshd_config"

 warning("sshd_config::mod with $key and $value and $name")

 augeas { "$name":
   name => $name,
   context => "$context",
   onlyif  => "get $key != '$value'",
   changes => "set $key '$value'",
#     notify  => Exec["sysctl"],
  }
} #end sysctl::mod

sshd_config::mod { 'mod1': 
  name => 'sshd_config-mod1',
  key => 'ClientAliveInterval',
  value => '3000',
 }

sshd_config::mod { 'mod2': 
  name => 'sshd_config-mod2',
  key => 'ClientAliveCountMax',
  value => '10',
 }

sshd_config::mod { 'mod3': 
  name => 'sshd_config-mod3',
  key => 'HostbasedAuthentication',
  value => 'no',
 }

sshd_config::mod { 'mod4': 
  name => 'sshd_config-mod4',
  key => 'PermitRootLogin',
  value => 'no',
 }

 sshd_config::mod { 'mod5':
   name => 'sshd_config-mod5',
   key => 'PermitEmptyPasswords',
   value => 'no',
  }

 sshd_config::mod { 'mod6':
   name => 'sshd_config-mod6',
   key => 'Protocol',
   value => '2',
  }

 sshd_config::mod { 'mod7':
   name => 'sshd_config-mod7',
   key => 'Banner',
   value => '/etc/issue',
  }

 sshd_config::mod { 'mod8':
   name => 'sshd_config-mod8',
   key => 'Ciphers',
   value => 'aes256-cbc,blowfish-cbc',
  }

} #end sysctl::conf

include sysctl::conf
