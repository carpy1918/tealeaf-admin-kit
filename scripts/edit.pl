#!/usr/bin/perl -w

use File::Copy;

#management of the entries in config files, insert and edit
my $CFILE = shift();
my $ADDITION = shift();
my $SEPARATOR=shift();

if(! $CFILE || ! $ADDITION || ! $SEPARATOR)
{ print "Syntax: edit.pl <config_file> <mod_file> <(=|\\t)>\n";exit; }

if($SEPARATOR eq "=")
{ print "Config file type: equal separated\n"; }
elsif($SEPARATOR eq "\\t")
{ 
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
my @configv;
my @modv;

my $COUNT=0;		#keep track of config file entry
my $COUNTn=0;		#keep track of change file entry
my $debug=1;
my $deleteline=0;	#delete config line

#Function: compareLine($$)
#Desc: compare to configuration lines
sub compareLine($$)
{
  my $configstr=shift();
  my $modstr=shift();
  my $count=0;
  my $result=0;
  my $configcommentflag=0;		#mark if there is a comment at line end
  my $modcommentflag=0;		#mark if there is a comment at line end
  my $configcomment='';		#config comment string
  my $modcomment='';		#mod comment string

  print "compareLine: strings: $configstr and $modstr\n" if $debug;

  $configstr =~ s/(#.*)//;
  $configcomment = $1;
  $configcommentflag=1 if $configcomment;
  $modstr =~ s/(#.*)//;
  $modcomment = $1;
  $modcommentflag=1 if $modcomment;
  $deleteline = 1 if $modcomment =~ /DELETE/;

  if($SEPARATOR eq "=")
  {
    @configv=split(/\s*$SEPARATOR\s*/,$configstr);
    @modv=split(/\s*$SEPARATOR\s*/,$modstr);
  }
  elsif($SEPARATOR eq '\t')
  {
    @configv=split(/(\s*$SEPARATOR\s*|\s*\s\s*)/,$configstr);
    @modv=split(/(\s*$SEPARATOR\s*|\s*\s\s*)/,$modstr);
  }
  else
  {
    print "compareLine: $SEPARATOR not found.\n";
    exit;
  }

  cleanArray();		#remove line separators or blanks
  my $configsize=@configv-1;
  my $modsize=@modv-1;

  if($configsize != $modsize) { 
    print "compareLine: config line length: $configsize and $modsize do not match\n" if $debug; 
    return 1; }   

  for($count=0;$count<$configsize;$count++) {	#compare line values
    print "compareLine: for: $configv[$count] and $modv[$count] : count: $count\n" if $debug;
    $return=compareValue($configv[$count],$modv[$count]);
    if($return == 0)
    { print "compareLine: for: config line match.\n" if $debug; }
    else
    { print "compareLine: for: no match\n" if $debug; return 1; } #return non-matching general error
  } 

  $result=compareValue($configv[$configsize],$modv[$configsize]);

  my $SEP;
  if($SEPARATOR eq "\\t")
  { $SEP = "	"; }
  else
  { $SEP = " = "; }

  if ($result==0)
  { 
    return 0 if $configcommentflag == 0 && $modcommentflag == 0;
    for ($count=0;$count<$configsize;$count++)
    {
      $modified .= $configv[$count] . "$SEP";
    }
    $modified .= $modv[$configsize] . "$SEP" . $modcomment if $modcommentflag == 1;
    $modified .= $modv[$configsize] . "$SEP" . $configcomment if $configcommentflag == 1 && $modcommentflag == 0; 
    return 2;
  } 
  elsif($result==1)
  { 
    for ($count=0;$count<$configsize;$count++)
    {
      $modified .= $configv[$count] . "$SEP";
    }
    $modified .= $modv[$configsize] if $modcommentflag == 0 && $configcommentflag == 0;
    $modified .= $modv[$configsize] . "$SEP" . $modcomment if $modcommentflag == 1;
    $modified .= $modv[$configsize] . "$SEP" . $configcomment if $configcommentflag == 1 && $modcommentflag == 0; 
    return 2;
  }
  else
  { print "compareLine: error handling $configv[$configsize] and $modv[$configsize]\n" if $debug; } 
} #end compareLine

#Function: compareValue($$)
#Desc: compare two string field values
sub compareValue($$)
{
  my $orig=shift();
  my $replace=shift();
  
  return 0 if( "$orig" eq "$replace");
  return 1;  
} #end compareValue

##Function: cleanArray($$)
##Desc: clean an array of separator values
sub cleanArray()
{
  my @TEMP;
  my @TEMP2;

  foreach(@configv)
  {
    if( $_ !~ /(^\s*$|^\s*=\s*$|^$)/ )
    { push(@TEMP,$_); }
  } #end foreach 
  @configv = @TEMP; 

  foreach(@modv)
  {
    if( $_ !~ /(^\s*$|^\s*=\s*$|^$)/ )
    { push(@TEMP2,$_); }
  } #end foreach
  @modv = @TEMP2;
} #end cleanArray


foreach(@MERGE)		#for each config file entry check it against the changefile
{
  my $config=$_;
  next if $config eq "";
  chomp($config);
  @configv=('');
  @modv=('');
  foreach(@NEW)		#for each changefile entry
  {
    my $mod=$_;
    next if $mod eq "";
    chomp($mod);
    $modified='';
    #0 == match, 1 == mismatch, 2 == last config value mismatch. 
    print "main: changefile loop: comparing lines: $config and $mod\n" if $debug;
    my $result=compareLine($config,$mod); 
    if($result==0)
    { 
      print "main: cfl: config line match: deleteline: $deleteline\n" if $debug;
      $NEW[$COUNTn]='';
      $MERGE[$COUNT]='' if $deleteline==1;
      $deleteline=0;
    }
    elsif($result==2)
    { 
      print "main: config line edit: going to use: $modified\n" if $debug;
      $MERGE[$COUNT]=$modified . "\n";		#update config value
      $MERGE[$COUNT]='' if $deleteline==1;
      $NEW[$COUNTn]='';				#erase change file value
      $deleteline=0;
    }
    else
    { print "main: config line mismatch\n" if $debug; }
    $COUNTn++;
  } #end foreach NEW 
  $COUNT++;
  $COUNTn=0;
  print "COUNTn: $COUNTn COUNT: $COUNT\n" if $debug;
} #foreach MERGE

foreach(@NEW)
{
  my $new=$_;
  next if $new eq '';
  print "main: adding $new to MERGE\n" if $debug;
  push(@MERGE,$new);
}
foreach(@MERGE)		#print config file
{ 
  print fh2 $_; 
}
