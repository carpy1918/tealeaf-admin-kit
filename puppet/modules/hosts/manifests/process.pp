
class process {

$file = '/etc/hosts'
$datahash = { 	
		'127.0.0.1' => 'localhos',
		'192.168.85.254' => 'mngtsvr.carpy.net'
} #end hash

#$datahash.each |$key, $value| { notify{ $key: message => "$key $value" } } #end hash
$datahash.each |$key, $value| { 

augeas { $key: 
   name => $key,
   context => "/files/etc/hosts",
   changes => "set *[ipaddr = $key]/canonical $value",		#[set|rm|clear] <VALUE> <PATH>, or ARRAY of commands
   load_path => "/usr/share/augeas/lenses/"
#   onlyif => "match $value not_include $file",
 } #end type
} #end each

augeas { blah: 
   name => 'blah',
   context => '/files/etc/hosts',
   changes => [ "set ipaddr 192.168.85.111",
		"set canonical blah" ],		#[set|rm|clear] <VALUE> <PATH>, or ARRAY of commands
   load_path => "/usr/share/augeas/lenses/"
 } #end type

} #end class

include process
