#!/usr/bin/perl

#
#check for tcp traffic errors using sar
#

my $debug=0;
my $max=25;
my $count=0;
my @tcpdata;
my $host=`hostname`;
chomp($host);

if( ! -f "/usr/bin/sar")
{  
  print "TCP-PERF-CHECK: sar not installed\n";
  exit; 
}

foreach my $d (`sar -T | awk '{print \$2" "\$3" "\$4" "\$5" "\$6}'`)
{
  @tcpdata = split(" ",$d);
  foreach my $d (@tcpdata)
  {
    if ($d > $max )
    {
      $count++;
    }
  }

  if ( $count > 1 )
  {  print "TCP-PERF-CHECK: PKT ERROR WARNING: $count found\n"; }
  elsif($count > 2)
  { print "TCP-PERF-CHECK: PKT ERROR ALERT: $count found\n"; }
  else
  { print "TCP-PERF-CHECK: PKT ERROR count: $count\n"; }

}


