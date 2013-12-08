#!/usr/bin/perl -w

use File::Copy;

#
#management of the entries in config files, insert and edit
#

my $CFILE = shift();
my $ADDITION = shift();
if(! $CFILE || ! $ADDITION)
{ print "Bad or no file given on CL\nSyntax: config-edit-tab.pl <config_file> <mod_file>\n";exit; }

copy("$CFILE","$CFILE.bkup") or die("Cannot copy $CFILE:$!\n");
open(fh1,"$ADDITION") or die("cannot open $ADDITION\n");
open(fh3,"$CFILE.bkup") or die("cannot open $CFILE.bkup\n");
open(fh2,">$CFILE") or die("cannot open $CFILE\n");
my @NEW=<fh1>;
my @BKUP=<fh3>;
my @MERGE=@BKUP;
our $modified = '';
our $SEPARATOR="\t";
my $COUNT=0;		#keep track of config file entry
my $COUNTn=0;		#keep track of change file entry
my $debug=0;

#
#Function: compareLine($$)
#Desc: compare to configuration lines
sub compareLine($$)
{
  my @configv=split(/\t|\s\s+/,shift());
  my @modv=split(/\t|\s\s+/,shift());
  my $count=0;
  my $result=0;
  my $depth=0;

  if($#configv!=$#modv)
  { 
    print "compareLine: line length configv $#configv and modv $#modv does not match\n" if $debug; 
    return 1; 
  }   

  $depth=$#configv;
  for($count=0;$count<$#configv;$count++)
  {
    print "compareLine: values: $configv[$count] and $modv[$count]\n" if $debug;
    $return=compareValue($configv[$count],$modv[$count]);
    if($return == 0)
    { print "$count: $configv[$count] and $modv[$count] Cvalues match.\n" if $debug; }
    else
    { print "$configv[$count] and $modv[$count] do not match\n" if $debug; return 1; } #return non-matching general error
  } #end for loop 

  $result=compareValue($configv[$depth],$modv[$depth]);
  if ($result==0)
  { return 0; } 
  elsif($result==1)
  { 
    for ($count=0;$count<$depth;$count++)
    {
      $modified .= $configv[$count] . $SEPARATOR;
    }
    $modified .= $modv[$depth];
    return 2;
  }
  else
  { print "compareLine: error handling $configv[$depth] and $modv[$depth]\n" if $debug; } 
} #end compareLine

#
#Function: compareValue($$)
#Desc: compare two string field values
sub compareValue($$)
{
  my $orig=shift();
  my $replace=shift();
  
  return 0 if( "$orig" eq "$replace");

  return 1;  
} #end compareValue

foreach(@MERGE)		#loop with each config file entry check it against the changefile
{
  my $config=$_;
  chomp($config);
  foreach(@NEW)		#loop through changefile
  {
    my $mod=$_;
    chomp($mod);
    $modified='';
    #0 == match, 1 == mismatch, 2 == last config value mismatch. 
    print "main: comparing lines: $config and $mod\n" if $debug;
    my $result=compareLine($config,$mod); 
    if($result==0)
    { 
      print "main: config line match: erasing new line at $COUNTn: $NEW[$COUNTn]\n" if $debug;
      $NEW[$COUNTn]='';
    }
    elsif($result==2)
    { 
      print "main: config line edit: $config : $mod merge. Going to use: $modified\n" if $debug;
      $MERGE[$COUNT]=$modified . "\n";		#update config value
      $NEW[$COUNTn]='';				#erase change file value
    }
    else
    { print "main: config line mismatch.\n" if $debug; }
    $COUNTn++;
    print "NEW END: COUNTn: $COUNTn COUNT: $COUNT\n" if $debug;
  } #end foreach NEW 
  $COUNT++;
  $COUNTn=0;
  print "MERGE END: COUNTn: $COUNTn COUNT: $COUNT\n" if $debug;
} #foreach MERGE

foreach(@NEW)
{
  my $new=$_;
  next if $new eq '';
  print "Adding $new to MERGE\n" if $debug;
  push(@MERGE,$new);
}
foreach(@MERGE)		#print config file
{ 
  print fh2 $_; 
}
