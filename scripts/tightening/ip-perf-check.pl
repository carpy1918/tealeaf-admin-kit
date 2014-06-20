#!/usr/bin/perl

#
#check for ip traffic errors using sar
#

my $debug=0;
my $warn=25;
my $error=50;
my @ipdata;
my $host=`hostname`;
chomp($host);
my @hder;
my @ader;
my @unkp;
my @ratim;
my @rfail;
my @nort;
my $hdercount=0;
my $adercount=0;
my $unkpcount=0;
my $ratimcount=0;
my $rfailcount=0;
my $nortcount=0;

if( ! -f "/usr/bin/sar")
{  
  print "TCP-PERF-CHECK: sar not installed\n";
  exit; 
}

foreach my $d (`sar -W | awk '{print \$3" "\$4" "\$5" "\$6" "\$7" "\$9}'`)
{
  @tcpdata = split(" ",$d);
  push(@hderr,$ipdata[0]);
  push(@ader,$ipdata[1]);
  push(@unkp,$ipdata[2]);
  push(@ratim,$ipdata[3]);
  push(@rfail,$ipdata[4]);
  push(@nort,$ipdata[5]);
}

foreach my $d (@hderr)
{
  if ($d > $max )
  {
    $hderrcount++;
  }
}

foreach my $d (@ader)
{
  if ($d > $max )
  {
    $adercount++;
  }
}

foreach my $d (@unkp)
{
  if ($d > $max )
  {
    $unkpcount++;
  }
}

foreach my $d (@ratim)
{
  if ($d > $max )
  {
    $ratimcount++;
  }
}

foreach my $d (@rfail)
{
  if ($d > $max )
  {
    $rfailcount++;
  }
}

my $hdercount=0;
my $adercount=0;
my $unkpcount=0;
my $ratimcount=0;
my $rfailcount=0;
my $nortcount=0;

if( $hderrcount > $warn || $adercount > $warn || $unkpcount > $warn || $ratimcount > $warn || $rfailcount > $warn || $nortcount > $warn)
{ print "IP-PERF-CHECK: PKT ERROR WARNING: inerr: $inerrcount retrans: $retranscount attfail: $attfailcount estabreset: $estrbresetcount outreset: $outresetfound\n"; }
elsif( $hderrcount > $error || $adercount > $error || $unkpcount > $error || $ratimcount > $error || $rfailcount > $error || $nortcount > $error)
{ print "IP-PERF-CHECK: PKT ERROR ALERT: inerr: $inerrcount retrans: $retranscount attfail: $attfailcount estabreset: $estabresetcount outreset: $outresetcount\n"; }
else
{ print "IP-PERF-CHECK: PKT ERROR INFO: inerr: $inerrcount retrans: $retranscount attfail: $attfailcount estabreset: $estabresetcount outreset: $outresetcount\n"; }

