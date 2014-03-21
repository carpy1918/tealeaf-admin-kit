#!/usr/bin/perl -w

use File::Copy;

#
#management of the entries in config files, insert and edit
#

my $CFILE = shift();
my $ADDITION = shift();
my $SEPARATOR=shift();

if(! $CFILE || ! $ADDITION || ! $SEPARATOR)
{ print "Syntax: config-edit-tab.pl <config_file> <mod_file> <(=|\\t)>\n";exit; }

if($SEPARATOR eq "=")
{ print "Config file type: equal separated\n"; }
elsif($SEPARATOR eq "\\t")
{ 
  $SEPARATOR = "\t";
  print "Config file type: \\t separated\n";
}
else 
{ 
  print "Config file separator type $SEPARATOR not supported\n"; 
  exit 1;
}

copy("$CFILE","$CFILE.bkup") or die("Cannot copy $CFILE:$!\n");
open(fh1,"$ADDITION") or die("cannot open $ADDITION\n");
open(fh3,"$CFILE.bkup") or die("cannot open $CFILE.bkup\n");
open(fh2,">$CFILE") or die("cannot open $CFILE\n");
my @NEW=<fh1>;
my @BKUP=<fh3>;
my @MERGE=@BKUP;
my $modified = '';

my $COUNT=0;		#keep track of config file entry
my $COUNTn=0;		#keep track of change file entry
my $debug=1;

#
#Function: compareLine($$)
#Desc: compare to configuration lines
sub compareLine($$)
{
  my $configstr=shift();
  my $modstr=shift();
  my @configv;
  my @modv;
  my $count=0;
  my $result=0;

  print "compareLine: strings: $configstr and $modstr\n" if $debug;

  if($SEPARATOR eq "=")
  {
    @configv=split(/(\s*$SEPARATOR\s*|\s\s*$SEPARATOR\s*)/,$configstr);
    @modv=split(/(\s*$SEPARATOR\s*|\s\s*$SEPARATOR\s\s*)/,$modstr);
  }
  else
  {
    @configv=split(/(\s*$SEPARATOR\s*|\s\s*)/,$configstr);
    @modv=split(/(\s*$SEPARATOR\s*|\s\s*)/,$modstr);
  }

  cleanArray();
  my $configsize=@configv;
  my $modsize=@modv;

  print "compareLine: printing arrays for $configstr and $modstr:\n" if $debug;
  foreach(@configv)
  { print "configv value: \"$_\"\n" }
  foreach(@modv)
  { print "modv value: \"$_\"\n" }
  print "compareLine: array depths: $configsize and $modsize\n" if $debug;

  if($configsize != $modsize)
  { 
    print "compareLine: config line length cl: $configsize and cfl: $modsize does not match\n" if $debug; 
    return 1; 
  }   

  print "compareLine: depth: $configsize\n" if $debug;
  for($count=0;$count<$configsize;$count++)	#compare line values
  {
    print "compareLine: values: $configv[$count] and $modv[$count]\n" if $debug;
    $return=compareValue($configv[$count],$modv[$count]);
    if($return == 0)
    { print "$count: $configv[$count] and $modv[$count] cfv match.\n" if $debug; }
    else
    { print "$configv[$count] and $modv[$count] do not match\n" if $debug; return 1; } #return non-matching general error
  } #end for loop 

  print "calling compareValue with: $configv[$configsize] and $modv[$configsize] configsize: $configsize\n";
  $result=compareValue($configv[$configsize],$modv[$configsize]);
  if ($result==0)
  { return 0; } 
  elsif($result==1)
  { 
    for ($count=0;$count<$configsize;$count++)
    {
      $modified .= $configv[$count] . $SEPARATOR;
    }
    $modified .= $modv[$configsize];
    return 2;
  }
  else
  { print "compareLine: error handling $configv[$configsize] and $modv[$configsize]\n" if $debug; } 
} #end compareLine

#
#Function: compareValue($$)
#Desc: compare two string field values
sub compareValue($$)
{
  my $orig=shift();
  my $replace=shift();
  
  print "compareValue: with orig: $orig and $replace\n" if $debug; 

  return 0 if( "$orig" eq "$replace");
  return 1;  
} #end compareValue

#
##Function: cleanArray($$)
##Desc: clean an array of separator values
sub cleanArray()
{
  my @TEMP;
  my @TEMP2;

  my $configsize=@configv;
  my $modsize=@modv;

  print "cleanArray: start sizes: $configsize and $modsize\n";

  foreach(@configv)
  {
    if( ! $_ =~ /(\s+|=)/ )
    { push(@TEMP,$_); }
  } #end foreach 
  @configv = @TEMP; 

  foreach(@modv)
  {
    if( ! $_ =~ /(\s+|=)/ )
    { push(@TEMP2,$_); }
  } #end foreach
  @modv = @TEMP2;

  print "cleanArray: end sizes: $configsize and $modsize\n";

} #end cleanArray



foreach(@MERGE)		#for each config file entry check it against the changefile
{
  my $config=$_;
  chomp($config);
  print "MERGE: lv: $config\n" if $debug;
  foreach(@NEW)		#for each changefile entry
  {
    my $mod=$_;
    chomp($mod);
    print "MOD: lv: $mod\n" if $debug;
    $modified='';
    #0 == match, 1 == mismatch, 2 == last config value mismatch. 
    print "main: changefile loop: comparing lines: $config and $mod\n" if $debug;
    my $result=compareLine($config,$mod); 
    if($result==0)
    { 
      print "main: cfl: config line match: erasing new line at $COUNTn: $NEW[$COUNTn]\n" if $debug;
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
    print "CHANGEFILE END: COUNTn: $COUNTn COUNT: $COUNT\n" if $debug;
  } #end foreach NEW 
  $COUNT++;
  $COUNTn=0;
  print "CONFIG LINE END: COUNTn: $COUNTn COUNT: $COUNT\n" if $debug;
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
