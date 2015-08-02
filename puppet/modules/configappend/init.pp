class configappend {

$file = '/etc/hosts'
$datahash = {
	'127.0.0.1' => 'localhost',
	'192.168.85.254' => 'mngtsvr.carpy.net'
} #end hash

$datahash.each |$key, $value| { 

augeas { $key: 
  name => $key,
  context => "/files/etc/hosts",
  changes => "set *[ipaddr = $key]/canonical $value",		#[set|rm|clear] <VALUE> <PATH>, or ARRAY of commands
  load_path => "/usr/share/augeas/lenses/",
  lens => "hosts.lns"
#   onlyif => "match $value not_include $file",
 } #end type

} #end each

} #end configappend

include configappend
