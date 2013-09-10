#!/usr/bin/perl
#MS Scan File filterer - filter only parts of the dataset we need.

use strict;
use warnings;

#perl msscan_filterer.pl $FILE $FILE.out
#perl msscan_filterer.pl A03F.text A03F.out

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

#Declare files
open (INFILE, "<$infile") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';


#For file, get grab line if TRUE
my $firstline = <INFILE>;
chomp $firstline;
print OUTFILE "$firstline\tTotal Ion Intensity\n";

my @file=<INFILE>;

my @filtered_file=();

#Push only lines that satisfies criteria to a temporary array 
foreach  my $line (@file){
	next if $line=~m/peptide/;
	my @linedata=split(/\t/,$line);
	
	my $true_column=$linedata[16];
	
	if ($true_column eq 'TRUE'){ 
		push(@filtered_file,$line); 
	}
}
close INFILE;

#For each line, get TIC form total area and total background columns
for my $i (0..$#filtered_file){

	my @linedata=split(/\t/,$filtered_file[$i]);
	my $total_area = $linedata[18];
	my $total_background = $linedata[17];
	
	chomp $total_area;
	chomp $total_background;
	my $total_ion_intensity = $total_area - $total_background;
		if ($total_ion_intensity < 0) { $total_ion_intensity = 0;}
	chomp $filtered_file[$i];
	$filtered_file[$i] .= "\t$total_ion_intensity\n";
}

foreach my $line (@filtered_file){
	print OUTFILE $line unless $line=~m/^\t\n/;
}
