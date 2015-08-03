class login::conf {

file { "login":
  name => $operatingsystem ? {
  default => "/etc/login.defs",
   },
}

# exec { "login":
#   command => "/etc/init.d/ reload",
#   alias       => "sshdconfig",
#   refreshonly => true,
#   subscribe   => File["login"],
#}

define login::mod ( $key, $value ) {
 $context = "/files/etc/login.defs"

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
  key => 'MAIL_DIR',
  value => '/var/spool/mail',
 }

login::mod { 'mod2': 
  name => 'login-mod2',
  key => 'MAIL_FILE',
  value => '.mail',
 }

login::mod { 'mod3': 
  name => 'login-mod3',
  key => 'PASS_MAX_DAYS',
  value => '180',
 }

login::mod { 'mod4': 
  name => 'login-mod4',
  key => 'PASS_MIN_DAYS',
  value => '1',
 }

 login::mod { 'mod5':
   name => 'login-mod5',
   key => 'PASS_MIN_LEN',
   value => '12',
  }

 login::mod { 'mod6':
   name => 'login-mod6',
   key => 'PASS_WARN_AGE',
   value => '14',
  }

 login::mod { 'mod7':
   name => 'login-mod7',
   key => 'UID_MIN',
   value => '500',
  }

 login::mod { 'mod8':
   name => 'login-mod8',
   key => 'UID_MAX',
   value => '60000',
  }

 login::mod { 'mod9':
   name => 'login-mod9',
   key => 'GID_MIN',
   value => '500',
  }

login::mod { 'mod10':
name => 'login-mod10',
key => 'GID_MAX',
value => '60000',
}

login::mod { 'mod11':
name => 'login-mod11',
key => 'REATE_HOME',
value => 'yes',
}

login::mod { 'mod12':
name => 'login-mod12',
key => 'UMASK',
value => '077',
}

login::mod { 'mod13':
name => 'login-mod13',
key => 'USERGROUPS_ENAB',
value => 'yes',
}

login::mod { 'mod14':
name => 'login-mod14',
key => 'ENCRYPT_METHOD',
value => 'SHA512',
}

} #end login::conf

include login::conf
