#!/usr/bin/perl
#Protein collapser - Get only the most abundant filename on a per protein basis.

use strict;
use warnings;

#perl protein_collapser.pl A03F.text.out.test A03F.text.out.txt.temp

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

open (FILE, "<$infile") or die "No file\n\n";
open (OUTPUT, ">$outfile") or die "No file\n\n";

my @file=<FILE>;
my @filtered_file=();

foreach  my $line (@file){
	push(@filtered_file,$line);
}
close FILE;

my %protein_hash=();
for my $i (0..$#filtered_file){

	my @linedata=split(/\t/,$filtered_file[$i]);
	my $protein=$linedata[0];
	my $filename=$linedata[1];

	if($protein_hash{$protein}) {
		chomp $filtered_file[$protein_hash{$protein}-1];
		$filtered_file[ $protein_hash{$protein}-1 ] .= "\t\n";
		$filtered_file[$i]="\n";
	}
	else{
		$protein_hash{$protein}=$i+1;
	}
}

foreach my $line (@filtered_file){
	print OUTPUT $line unless $line=~m/^$/;
}
