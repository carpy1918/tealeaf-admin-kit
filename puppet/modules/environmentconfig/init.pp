#
# variable for puppet management on network
#


case $::osfamily {

  'Redhat': {

  $config = '/etc/resolv'
  $bkupdir='/tmp/tealeaf/'
  $email="curtis@carpy.net"
  $dnsservers= [
    '192.168.159.1',
    '192.168.159.2'
  ]
} #end Redhat

  'Debian': {

  $config = '/etc/resolv'
  $bkupdir='/tmp/tealeaf/'
  $email="curtis@carpy.net"
  $dnsservers= [
    '192.168.159.1',
    '192.168.159.2'
  ]

} #end Debian

  'SuSE': {

  $config = '/etc/resolv'
  $bkupdir='/tmp/tealeaf/'
  $email="curtis@carpy.net"
  $dnsservers= [
    '192.168.159.1',
    '192.168.159.2'
  ]

} #SuSE

  'Linux': {

  $config = '/etc/resolv'
  $bkupdir='/tmp/tealeaf/'
  $email="curtis@carpy.net"
  $dnsservers= [
    '192.168.159.1',
    '192.168.159.2'
  ]

} #end Linux

  'default': {
  fail('environmentconfig: the specified Linux OS is not supported by this module')
}

} #end case
