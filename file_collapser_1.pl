#!/usr/bin/perl
#File collapser 1 - collapse by type (flg or h20)

use strict;
use warnings;

#usage: perl file_collapser_1.pl A10H.final A10F.final A10.collapsed1

my $h2o = $ARGV[0];
my $flg = $ARGV[1];
my $OUTFILE = $ARGV[2];

open (INFILE1, "<$h2o") or die 'File cannot be opened\n\n';
open (INFILE2, "<$flg") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$OUTFILE") or die 'File cannot be opened\n\n';

$h2o =~ s/\.final//;
$flg =~ s/\.final//;

#PeptideSequence\tProteinName\tPrecursorMz\tA10HTripletSum\tA10Hfilename\tA10HFlag\tA10FTripletSum\tA10Ffilename\tA10FFlag
print OUTFILE "PeptideSequence\tProteinName\tPrecursorMz\t$h2o.TripletSum\t$h2o.Filename\t$h2o.Flag\t$flg.TripletSum\t$flg.Filename\t$flg.Flag\n";

# my ($scan_count1, $scan_count2, $summed_intensities1, $summed_intensities2, @temp_array1, @temp_array2);

my ($peptide1,$precursor1,$peptide2,$precursor2);

my %hash1;
while (<INFILE1>) {
	chomp;
	next if $_=~m/peptide/;
	my @linedata1 = split(/\t/);
	# my $peptide1 = $linedata1[0];
	# my $precursor1 = $linedata1[2];
	$peptide1 = $linedata1[0];
	$precursor1 = $linedata1[2];
	$hash1{$peptide1}{$precursor1}= [@linedata1];
}

my %hash2;
while (<INFILE2>) {
	chomp;
	next if $_=~m/peptide/;
	my @linedata2 = split(/\t/);
	# my $peptide2 = $linedata2[0];
	# my $precursor2 = $linedata2[2];
	$peptide2 = $linedata2[0];
	$precursor2 = $linedata2[2];
	$hash2{$peptide2}{$precursor2}= [@linedata2];
}

foreach my $i(keys %hash1){
	if (exists $hash2{$i} ) {
	foreach my $j(keys %{$hash1{$i}}){
		print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[20]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[22]\t$hash2{$i}{$j}[20]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[22]\n";
		}
	}
}

#for h2o flg22
foreach my $i(keys %hash1){
	if (exists $hash2{$i} ) {
	foreach my $j(keys %{$hash1{$i}}){
		print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[20]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[22]\t$hash2{$i}{$j}[20]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[22]\n";
		}
	}
}

#for h20 
foreach my $i(keys %hash1){
	unless (exists $hash2{$i} ) {
	foreach my $j(keys %{$hash1{$i}}){
		print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[20]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[22]\tNA\tNA\tNA\n";
		}
	}
}

#for    flg22 
foreach my $i(keys %hash2){
	unless (exists $hash1{$i} ) {
	foreach my $j(keys %{$hash2{$i}}){
		print OUTFILE "$i\t$hash2{$i}{$j}[1]\t$j\tNA\tNA\tNA\t$hash2{$i}{$j}[20]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[22]\n";
		}
	}
}
