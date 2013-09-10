#!/usr/bin/perl
#Protein Counter - count protein-filename combinations for later use in the program.

use strict;
use warnings;

#perl proteincounter_msscan.pl $FILE $FILE.txt

my $infile = $ARGV[0];
my $outfile = $ARGV[1];
my $outfile2 = $ARGV[2];

open (INFILE, "<$infile") or die 'File cannot be opened\n\n';
open (TEMP, ">temp.txt") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';
open (OUTFILE2, ">$outfile2") or die 'File cannot be opened\n\n';

my @array2;
while (<INFILE>) {
	chomp;
	next if ($_=~m/PeptideSequence/);
	my @linedata=split(/\t/,$_);
	my $protein = $linedata[1];
	my $filename = $linedata[14];
	push (@array2,"$filename");
	print TEMP "$protein\t$filename\n";
}

# print @array2;
close (TEMP);

open (TEMP, "<temp.txt") or die 'File cannot be opened\n\n';

my @array;
while (<TEMP>) {
	chomp;
	push (@array,$_);
}

my %counts=();
map {$counts{$_}++} @array;
foreach my $key (sort { $counts{$b} <=> $counts{$a} } keys %counts) {
	print OUTFILE "$key\t$counts{$key}\n";
}

my %counts2=();
map {$counts2{$_}++} @array2;
foreach my $key2 (sort { $counts2{$b} <=> $counts2{$a} } keys %counts2) {
	print OUTFILE2 "$key2\t$counts2{$key2}\n";
}
