#!/usr/bin/perl

#
#check the performance of swap using sar
#

my $debug=0;
my $warn=20;
my $error=30;
my $max=1000;
my $count=0;
my @swapdata;
my $host=`hostname`;
my $logfile='/tmp/tealeaf-disk.log';
chomp($host);
open(fh, "+>>".$logfile);

if( ! -f "/usr/bin/sar")
{
  print fh "SWAP-PERF-CHECK: sar not installed\n";
  exit;
}

foreach my $d (`sar -d | awk '{print \$4}'`)
{
  push(@swapdata,$d);
}

$count=0;
foreach my $d (@swapdata)
{
    if ($swapdata{$k} > $max )
    {
      $count++;
    }
}

if ( $count > $warn)
{ print fh "SWAP-PERF-CHECK: IN WARNING: $count found\n"; }
elsif($count > $error)
{ print fh "SWAP-PERF-CHECK: IN ALERT: $count found\n"; }
else
{ print fh "SWAP-PERF-CHECK: IN count: $count\n"; }

@swapdata=();
foreach my $d (`sar -d | awk '{print \$5}'`)
{
  push(@swapdata,$d);
}

$count=0;
foreach my $d (@swapdata)
{
    if ($swapdata{$k} > $max )
    {
      $count++;
    }
}

if ( $count > $warn)
{ print fh "SWAP-PERF-CHECK: OUT WARNING: $count found\n"; }
elsif($count > $error)
{ print fh "SWAP-PERF-CHECK: OUT ALERT: $count found\n"; }
else
{ print fh "SWAP-PERF-CHECK: OUT count: $count\n"; }
