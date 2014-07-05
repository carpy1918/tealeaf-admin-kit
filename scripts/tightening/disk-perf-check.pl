#!/usr/bin/perl

#
#check the performance of disk partitions using sar
#

my $debug=0;
my $max=1950;
my $warn=20;
my $error=30;
my $count=0;
my %diskdata;
my $logfile='/tmp/tealeaf-disk.log';
my $host=`hostname`;
open(fh,"+>>".$logfile);

chomp($host);

if( ! -f "/usr/bin/sar")
{  
  print fh "DSK-PERF-CHECK: sar not installed\n";
  exit; 
}

foreach my $d (`sar -d | awk '{print \$2" "\$4}'`)
{
  my @data=split(" ",$d);
  unless( "$data[0]" eq '' || "$data[0]" eq "device" || "$data[0]" eq "$host")
  {
    print fh "split data: $data[0] and $data[1]\n" if $debug;
    $diskdata{"$data[0]-$count"}=$data[1];  
    $count++;
  }
}

$count=0;
foreach my $k (keys %diskdata)
{
  if ($diskdata{$k} !~ "rdKb/s" && $diskdata{$k} !~ "")
  {  
    if ($diskdata{$k} > $max )
    {
      $count++;
    }
  }
}

if ( $count > $warn )
{  print fh "DISK-PERF-CHECK: READ WARNING: $count found\n"; }
elsif($count > $error)
{ print fh "DISK-PERF-CHECK: READ ALERT: $count found\n"; }
else
{ print fh "DISK-PERF-CHECK: READ count: $count\n"; }


foreach my $d (`sar -d | awk '{print \$2" "\$6}'`)
{
  my @data=split(" ",$d);
  unless( "$data[0]" eq '' || "$data[0]" eq "device" || "$data[0]" eq "$host")
  {
    print fh "split data: $data[0] and $data[1]\n" if $debug;
    $diskdata{"$data[0]-$count"}=$data[1];  
    $count++;
  }
}

$count=0;
foreach my $k (keys %diskdata)
{
  if ($diskdata{$k} !~ "rdKb/s" && $diskdata{$k} !~ "")
  {  
    if ($diskdata{$k} > $max)
    {
      $count++;
    }
  }
}

if ( $count > $warn)
{ print fh "DISK-PERF-CHECK: WRITE WARNING: $count found\n"; }
elsif($count > $error)
{ print fh "DISK-PERF-CHECK: WRITE ALERT: $count found\n"; }
else
{ print fh "DISK-PERF-CHECK: WRITE count: $count\n"; }

