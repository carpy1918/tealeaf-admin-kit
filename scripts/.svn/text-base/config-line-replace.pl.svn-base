#!/usr/bin/perl

#
#sed replacement for HP-UX and systems without sed -i
#


my $CONFSTR = shift();
my $CONFREPLACE = shift();
my $FILE = shift();
my $LOG='/tmp/search-and-replace.log';
my $DATE=`date`;
my $UNAME=`uname`;

if($FILE eq '')
{ print "No file given on CL\n";exit; }
print logger "$DATE\nMaking a backup of $FILE\n";
system(`cp $FILE $FILE.bkup`);

chomp($UNAME);
chomp($DATE);
open(fh1, "$FILE.bkup") or die("cannot open $FILE.bkup\n");
open(fh2, ">$FILE") or die("cannot open $FILE\n");
open(logger, ">>$LOG") or die("cannot open $LOG\n");

while(<fh1>)
{
  my $str=$_;
  chomp($str);
  if($str eq $CONFSTR)
  {  
     print logger "$DATE\nConfig line match: $str\n";
     $str = $CONFREPLACE;
     print logger "$DATE\nReplaced with: $CONFREPLACE\n";
  } 
  print fh2 "$str\n";
}

system(`mv $FILE.bkup /tmp/`);
