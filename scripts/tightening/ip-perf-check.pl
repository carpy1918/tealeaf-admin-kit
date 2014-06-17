#!/usr/bin/perl

#
#check for ip traffic errors using sar
#

my $debug=0;
my $max=25;
my $count=0;
my @ipdata;
my $host=`hostname`;
chomp($host);

if( ! -f "/usr/bin/sar")
{  
  print "DSK-PERF-CHECK: sar not installed\n";
  exit; 
}

foreach my $d (`sar -W | awk '{print \$3" "\$4" "\$5" "\$6" "\$7" "\$9}'`)
{
  @ipdata = split(" ",$d);
  foreach my $d (@ipdata)
  {
    if ($d > $max )
    {
      $count++;
    }
  }

  if ( $count > 1 )
  {  print "IP-PERF-CHECK: PKT ERROR WARNING: $count found\n"; }
  elsif($count > 2)
  { print "IP-PERF-CHECK: PKT ERROR ALERT: $count found\n"; }
  else
  { print "IP-PERF-CHECK: PKT ERROR count: $count\n"; }

}


