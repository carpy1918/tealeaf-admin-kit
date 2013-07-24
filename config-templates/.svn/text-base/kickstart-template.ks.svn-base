
install
cdrom

#nfs --server=<hostname> --dir=<directory> [--opts=<nfs options>]
#url --url=<url>|--mirrorlist=<url> [--proxy=<proxy url>] [--noverifyssl]

lang en_US.UTF-8
keyboard us

network --onboot yes --device eth0 --bootproto dhcp --noipv6
#network --bootproto=static --ip=10.0.2.15 --netmask=255.255.255.0 --gateway=10.0.2.254 --nameserver=10.0.2.1

#logging --host=syslog-ng --port=514 --level=info

rootpw  --iscrypted $6$jzp3NBi07yentEea$Nli2L9YdU0/56dNV/hj8SAU6AsMJ/D9842Adyytclvp0hF5Ly5pcuPxjTTLhm8FyTBQtMohKs/Ebo/0Ap85ge.
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512
selinux --enforcing
timezone --utc America/Chicago
bootloader --location=mbr --driveorder=sda --append="crashkernel=auto rhgb quiet"

#Disk configuration
clearpart --all --drives=sda

part /boot --fstype=ext4 --size=500
part pv.008002 --grow --size=1

volgroup vg_centos6464bit --pesize=4096 pv.008002
logvol / --fstype=ext4 --name=lv_root --vgname=vg_centos6464bit --grow --size=1024 --maxsize=51200
logvol swap --name=lv_swap --vgname=vg_centos6464bit --grow --size=1984 --maxsize=1984

repo --name="CentOS"  --baseurl=cdrom:sr0 --cost=100
#repo --name=<name> [--baseurl=<url>|--mirrorlist=<url>]

services --disabled=gvm,bluetooth,dund,hidd,irda,kudzu,zfs,conman,ip6tables,inetd,xinetd,rpcbind,rpcgssd,rpcidmapd,rpcsvcgssd,ypbind,ypserv,tftp-server,isdn,kdump,atd,portmapper

#user --name=<username> [--gecos=<string>] [--groups=<list>] [--homedir=<homedir>] [--password=<password>] [--iscrypted|--plaintext] [--lock] [--shell=<shell>] [--uid=<uid>]


%packages
@base
@console-internet
@core
@directory-client
@hardware-monitoring
@internet-browser
@large-systems
@network-file-system-client
@performance
@perl-runtime
@system-management-snmp
@server-platform
@server-policy
@storage-client-multipath
@system-management
@system-admin-tools
@x11
#@storage-client-iscsi
#@storage-client-multipath
#@compat-libraries
#@ha
#@java-platform
#@load-balancer
device-mapper-persistent-data
samba-winbind
certmonger
pam_krb5
krb5-workstation
-telnet-server
-ftp-server
-rsh-server
-@print-client
-@server-platform-devel
-@smart-card
telnet
-gcc

%post


