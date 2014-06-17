#!/usr/bin/perl

#
#check for tcp traffic errors using sar
#

my $debug=0;
my $warn=25;
my $error=50;
my @tcpdata;
my $host=`hostname`;
chomp($host);
my @inerr;
my @retrans;
my @attfail;
my @estabreset;
my @outreset;
my $inerrcount=0;
my $retranscount=0;
my $attfailcount=0;
my $estabresetcount=0;
my $outresetcount=0;

if( ! -f "/usr/bin/sar")
{  
  print "TCP-PERF-CHECK: sar not installed\n";
  exit; 
}

foreach my $d (`sar -T | awk '{print \$2" "\$3" "\$4" "\$5" "\$6}'`)
{
  @tcpdata = split(" ",$d);
  push(@inerr,$tcpdata[0]);
  push(@retrans,$tcpdata[1]);
  push(@attfail,$tcpdata[2]);
  push(@estabreset,$tcpdata[3]);
  push(@outreset,$tcpdata[4]);
}

foreach my $d (@inerr)
{
  if ($d > $max )
  {
    $inerrcount++;
  }
}

foreach my $d (@retrans)
{
  if ($d > $max )
  {
    $retranscount++;
  }
}

foreach my $d (@attfail)
{
  if ($d > $max )
  {
    $attfailcount++;
  }
}

foreach my $d (@estabreset)
{
  if ($d > $max )
  {
    $estabresetcount++;
  }
}

foreach my $d (@outreset)
{
  if ($d > $max )
  {
    $outresetcount++;
  }
}

if( $inerrcount > $warn || $retranscount > $warn || $attfailcount > $warn || $estabresetcount > $warn || $outresetcount > $warn )
{ print "TCP-PERF-CHECK: PKT ERROR WARNING: inerr: $inerrcount retrans: $retranscount attfail: $attfailcount estabreset: $estrbresetcount outreset: $outresetfound\n"; }
elsif( $inerrcount > $error || $retranscount > $error || $attfailcount > $error || $estabresetcount > $error || $outresetcount > $error )
{ print "TCP-PERF-CHECK: PKT ERROR ALERT: inerr: $inerrcount retrans: $retranscount attfail: $attfailcount estabreset: $estabresetcount outreset: $outresetcount\n"; }
else
{ print "TCP-PERF-CHECK: PKT ERROR INFO: inerr: $inerrcount retrans: $retranscount attfail: $attfailcount estabreset: $estabresetcount outreset: $outresetcount\n"; }

