
class process {

include data
include edit
include augeus

$file = '/etc/hosts'
$datahash.each |$key, $value| { notify("$key $value") } #end hash
$datahash.each |$key, $value| { edit::single($key, $value, $file) } #end hash

} #end hosts

class data {

#
#this is the hash that holds default /etc/hosts value for the network
#

$datahash = { 	

		'127.0.0.1' => 'localhost localhost.localdomain',
		'192.168.85' => 'mngtsvr mngtsvr.carpy.net'


} #end hash

} #end class

class edit ( $value = '', $path = '', $file = '' ) {

augeus { configedit: 
   name => '/etc/hosts mod',
   changes => "set $value \t $path",		#[set|rm|clear] <VALUE> <PATH>, or ARRAY of commands
   incl => "$file",
   lens => 'Host_Conf.lns',
   onlyif => "match $value not_include $file",
   type_check => true
 } #end type

} #end class

include process
