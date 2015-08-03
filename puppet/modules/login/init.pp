class login::conf {

file { "login":
  name => $operatingsystem ? {
  default => "/etc/ssh/login",
   },
}

 exec { "sshdconfig":
   command => "/etc/init.d/sshd reload",
   alias       => "sshdconfig",
   refreshonly => true,
   subscribe   => File["login"],
}

define login::mod ( $key, $value ) {
 $context = "/files/etc/ssh/login"

 warning("login::mod with $key and $value and $name")

 augeas { "$name":
   name => $name,
   context => "$context",
   onlyif  => "get $key != '$value'",
   changes => "set $key '$value'",
#     notify  => Exec["sysctl"],
  }
} #end sysctl::mod

login::mod { 'mod1': 
  name => 'login-mod1',
  key => 'ClientAliveInterval',
  value => '3000',
 }

login::mod { 'mod2': 
  name => 'login-mod2',
  key => 'ClientAliveCountMax',
  value => '10',
 }

login::mod { 'mod3': 
  name => 'login-mod3',
  key => 'HostbasedAuthentication',
  value => 'no',
 }

login::mod { 'mod4': 
  name => 'login-mod4',
  key => 'PermitRootLogin',
  value => 'no',
 }

 login::mod { 'mod5':
   name => 'login-mod5',
   key => 'PermitEmptyPasswords',
   value => 'no',
  }

 login::mod { 'mod6':
   name => 'login-mod6',
   key => 'Protocol',
   value => '2',
  }

 login::mod { 'mod7':
   name => 'login-mod7',
   key => 'Banner',
   value => '/etc/issue',
  }

 login::mod { 'mod8':
   name => 'login-mod8',
   key => 'Ciphers',
   value => 'aes256-cbc,blowfish-cbc',
  }

} #end sysctl::conf

include login::conf
