#!/usr/bin/perl -w

#
#management of the entries in config files, insert and edit
#

my $CFILE = shift();
my $ADDITION = shift();

if(! $CFILE || ! $ADDITION)
{ print "Bad file given on CL\nSyntax: config-edit-tab.pl <config_file> <mod_file>\n";exit; }

`cp $CFILE $CFILE.bkup`;
open(fh1, "$ADDITION") or die("cannot open $ADDITION\n");
open(fh3, "$CFILE.bkup") or die("cannot open $CFILE.bkup\n");
open(fh2, ">$CFILE") or die("cannot open $CFILE\n");
my @NEW=<fh1>;
my @BKUP=<fh3>;
my @MERGE=@BKUP;
our $modified = '';
our $SEPARATOR="\t";
my $COUNT=0;
my $debug=0;

#
#Function: compareLine($$)
#Desc: compare to configuration lines. 
sub compareLine($$)
{
  my @configv=split(/\t|\s\s+/,shift());
  my @modv=split(/\t|\s\s+/,shift());
  my $depth=$#configv;
  my $count=0;
  my $result=0;

#  return 1 if $depth == 0;
  foreach(@configv) {
   print "array values: $_ \n";
  }
  foreach(@modv) {
   print "array values: $_ \n";
  }

  if( $#configv != $#modv )
  {
    print "compareLine: line length configv $#configv and modv $#modv does not match\n";
    return 1;
  }

  print "In compareLine: array depth: $depth\n" if $debug;
  for ($count=0;$count<$depth;$count++)
  {
    print "compareLine: $configv[$count] and $modv[$count]\n";
    $return=compareValue($configv[$count],$modv[$count]);
    if($return == 0)
    { print "$count: Config values match.\n" if $debug; }
    else
    { print "$configv[$count] and $modv[$count] do not match\n" if $debug; return 1; } #return non-matching general error
  } #end for loop 

  $result=compareValue($configv[$depth],$modv[$depth]);
  if ($result==0)
  { return 0; } 
  elsif($result==1)
  { 
    for (my $count=0;$count<$depth;$count++)
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
  my $orig = shift();
  my $replace = shift();
  
  if( $orig eq $replace)
  { return 0; }
  else 
  { return 1; } 
} #end compareValue

foreach(@MERGE)		#loop with each config file entry check it against the changefile
{
  my $config=$_;
#  $config =~ s/\n//g;
  my $WRITTENv=0;
  my $COUNTn=0;
  foreach(@NEW)		#loop through changefile
  {
    my $mod;
    $mod=$_;
    print "new array value: $mod\n";
    $modified='';
#    $mod =~ s/\n//g;
    #0 == match, 1 == mismatch, 2 == last config value mismatch. 
    print "COUNTn: $COUNTn. COUNT: $COUNT\n" if $debug;
    print "++++Comparing lines: $config and $mod\n";
    my $result=compareLine($config,$mod); 
    if($result==0)
    { 
      print "COUNTn: $COUNTn. COUNT: $COUNT\n" if $debug;
      print "config lines match erasing new line $COUNTn:\nNEW: (erase) $NEW[$COUNTn] and MERGE: (orig) $MERGE[$COUNT]\n" if $debug;
      $NEW[$COUNTn]='';
    }
    elsif($result==2)
    { 
      print "COUNTn: $COUNTn. COUNT: $COUNT\n" if $debug;
      print "$config and $mod merge. Going to use: $modified\n";
      $MERGE[$COUNT]=$modified . "\n";
      $NEW[$COUNTn]='';
    }
    else
    { print "No match.\n" if $debug; }
    $COUNTn++;
  } #end foreach NEW 
  $COUNT++;
  print "End of MERGE loop.\n" if $debug;
  print "COUNTn: $COUNTn. COUNT: $COUNT\n" if $debug;
} #foreach MERGE

print "\nExiting compare and entering insert mode\n" if $debug;
foreach(@NEW)
{
  my $new = $_;
  next if $new eq '';
  print "Adding $new to MERGE\n" if $debug;
  push(@MERGE,$new);
}
foreach(@MERGE)		#print config file
{
  print fh2 $_;
}
