#!/usr/bin/perl

use strict;
use warnings;

my $file = $ARGV[0];
my $ofile = $ARGV[1];
open(INFILE, $file) || die "the file $file cannot be opened\n";
open(my $fh, ">>$ofile") || die "could not open file $ofile, $!";

my $sum=0.0;
my $count=1;
my $gid="";
my $fpkm=0.0;

my $line = <INFILE>;
my @entry = split("\t",$line);

$gid = $entry[0];
$fpkm = $entry[1];
$sum = $fpkm;


while ( $line = <INFILE> ) {
  @entry = split("\t", $line);

  if ($entry[0] eq $gid)
  {
     $count = $count + 1;
     $sum = $sum + $entry[1];
  }
  else
  {
     $fpkm = $sum / $count;
     print $fh $gid."\t".$fpkm."\n";
     $gid = $entry[0];
     $sum = $entry[1];
     $count = 1;
  }
}

$fpkm = $sum / $count;
print $fh $gid."\t".$fpkm;

close INFILE;
close $fh;
