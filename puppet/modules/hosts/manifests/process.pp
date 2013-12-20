class process {

#
#data values for /etc/ssh/sshd_config
#
$datahash = {

                'X11Forwarding' => 'no',
                'blah' => 'yes'


} #end hash



$file = '/files/etc/ssh/sshd_config'
each($datahash) |$key, $value| {

augeas { $key:
   name => $key,
   context => "$file",
   changes => "set $file/$key $value",          #[set|rm|clear] <VALUE> <PATH>
   load_path => "/usr/share/augeas/lenses/",
#   onlyif => "match $file/$key not_include disable",
} #end type

} #end each

} #end class

include process
