name=`uname -n`
kernel=`uname -r`
type=`uname -i`

echo "" > /etc/motd
echo "Server: $name" >> /etc/motd
echo "Kernel: $kernel" >> /etc/motd
echo "Type: $type" >> /etc/motd
echo "" >> /etc/motd

