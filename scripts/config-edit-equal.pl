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
our $SEPARATOR="=";
my $COUNT=0;
my $debug=1;

#
#Function: compareLine($$)
#Desc: compare to configuration lines. 
sub compareLine($$)
{
  my @configv=split(/\s*=\s*/,shift());
  my @modv=split(/\s*=\s*/,shift());
  my $depth=$#configv;
  my $count=0;
  my $result=0;

  return 1 if $depth < 0;

  if( $#configv != $#modv )
  { 
    print "compareLine: line length does not match\n" if $debug;
    return 1;
  }

  print "In compareLine: array depth: $depth.\n";
  for ($count=0;$count<$depth;$count++)
  {
    $return=compareValue($configv[$count],$modv[$count]);
    if($return == 0)
    { print "$count: Config values match.\n" if $debug; }
    else
    { return 1; } #return non-matching general error
  } #end for loop 
  $result=compareValue($configv[$depth],$modv[$depth]);
  if ($result==0)
  { return 0; } 
  elsif ($result==1)
  { return 1; }
  else
  {
    for (my $count=0;$count<$depth;$count++)
    {
      $modified .= $configv[$count] . $SEPARATOR;
    }
    $modified .= $modv[$depth];
    return 2;
  }
} #end compareLine

#
#Function: compareValue($$)
#Desc: compare two string field values
sub compareValue($$)
{
  my $orig = shift();
  my $replace = shift();
  
  if( $orig eq '' || $replace eq '' )
  { return 1; }

  if( $orig eq $replace)
  { return 0; }
  else 
  { return 1; } 
} #end compareValue


foreach(@MERGE)		#foreach config file entry check it against the old ones
{
  my $config=$_;
#  $config =~ s/\n//g;
  my $WRITTENv=0;
  my $COUNTn=0;
  foreach(@NEW)
  {
    $modified='';
    my $mod=$_;
#    $mod =~ s/\n//g;
    #0 == match, 1 == mismatch, 2 == last config value mismatch. 
    print "COUNTn: $COUNTn. COUNT: $COUNT\n" if $debug;
    print "Comparing line compare: $config and $mod\n" if $debug;
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
      print "$config and $mod merge. Going to use: $modified\n" if $debug;
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


