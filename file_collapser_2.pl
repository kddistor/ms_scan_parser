#!/usr/bin/perl
#File collapser 2 - collapse by replicate (rep1, rep2, rep3)
#usage: perl file_collapser_2.pl A10.collapsed1 B10.collapsed1 C10.collapsed1 10min.collapsed2

use strict;
use warnings;

my $rep1 = $ARGV[0];
my $rep2 = $ARGV[1];
my $rep3 = $ARGV[2];
my $outfile = $ARGV[3];

open (INFILE1, "<$rep1") or die 'File cannot be opened\n\n';
open (INFILE2, "<$rep2") or die 'File cannot be opened\n\n';
open (INFILE3, "<$rep3") or die 'File cannot be opened\n\n';
open (OUTFILE, ">$outfile") or die 'File cannot be opened\n\n';

$rep1 =~ s/\.\D+\d//;
$rep2 =~ s/\.\D+\d//;
$rep3 =~ s/\.\D+\d//;
#PeptideSequence\tProteinName\tPrecursorMz\t$rep1.10HTripletSum\t$rep1.10Hfilename\t$rep1.10HFlag\t$rep1.10FTripletSum\t$rep1.10Ffilename\t$rep1.10FFlag
# \t$rep2.10HTripletSum\t$rep2.10Hfilename\t$rep2.10HFlag\t$rep2.10FTripletSum\t$rep2.10Ffilename\t$rep2.10FFlag
# \t$rep3.10HTripletSum\t$rep3.10Hfilename\t$rep3.10HFlag\t$rep3.10FTripletSum\t$rep3.10Ffilename\t$rep3.10FFlag
print OUTFILE "PeptideSequence\tProteinName\tPrecursorMz\t$rep1.HTripletSum\t$rep1.Hfilename\t$rep1.HFlag\t$rep1.FTripletSum\t$rep1.Ffilename\t$rep1.FFlag\t$rep2.HTripletSum\t$rep2.Hfilename\t$rep2.HFlag\t$rep2.FTripletSum\t$rep2.Ffilename\t$rep2.FFlag\t$rep3.HTripletSum\t$rep3.Hfilename\t$rep3.HFlag\t$rep3.FTripletSum\t$rep3.Ffilename\t$rep3.FFlag\n";


my %hash1;
while (<INFILE1>) {
	chomp;
	next if $_=~m/Peptide/;
	my @linedata1 = split(/\t/);
	my $peptide1 = $linedata1[0];
	my $precursor1 = $linedata1[2];
	$hash1{$peptide1}{$precursor1}= [@linedata1];
}

my %hash2;
while (<INFILE2>) {
	chomp;
	next if $_=~m/Peptide/;
	my @linedata2 = split(/\t/);
	my $peptide2 = $linedata2[0];
	my $precursor2 = $linedata2[2];
	$hash2{$peptide2}{$precursor2}= [@linedata2];
}

my %hash3;
while (<INFILE3>) {
	chomp;
	next if $_=~m/Peptide/;
	my @linedata3 = split(/\t/);
	my $peptide3 = $linedata3[0];
	my $precursor3 = $linedata3[2];
	$hash3{$peptide3}{$precursor3}= [@linedata3];
}

# if in a b c
foreach my $i(keys %hash1){
	if (exists $hash2{$i} && exists $hash3{$i}) {
		foreach my $j(keys %{$hash1{$i}}){
			print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[8]\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[8]\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[8]\n";
		}
	}
}


#if in a b 
foreach my $i(keys %hash1){
	if (exists $hash2{$i}) {
		unless (exists $hash3{$i}) {
			foreach my $j(keys %{$hash1{$i}}){
				print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[8]\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[8]\tNA\tNA\tNA\tNA\tNA\tNA\n";
			}
		}
	}
}

# \tNA\tNA\tNA\tNA\tNA\tNA

#if in a
foreach my $i(keys %hash1){
	unless (exists $hash2{$i}) {
		unless (exists $hash3{$i}) {
			foreach my $j(keys %{$hash1{$i}}){
				print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[8]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
			}
		}
	}
}

#if in   b c
foreach my $i(keys %hash2){
	if (exists $hash3{$i}) {
		unless (exists $hash1{$i}) {
			foreach my $j(keys %{$hash2{$i}}){
				print OUTFILE "$i\t$hash2{$i}{$j}[1]\t$j\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[8]\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[8]\n";
			}
		}
	}
}

#if in   b
foreach my $i(keys %hash2){
	unless (exists $hash3{$i}) {
		unless (exists $hash1{$i}) {
			foreach my $j(keys %{$hash2{$i}}){
				print OUTFILE "$i\t$hash2{$i}{$j}[1]\t$j\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[8]\tNA\tNA\tNA\tNA\tNA\tNA\n";
			}
		}
	}
}

#if in a   c
foreach my $i(keys %hash1){
	if (exists $hash3{$i}) {
		unless (exists $hash3{$i}) {
			foreach my $j(keys %{$hash1{$i}}){
				print OUTFILE "$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[8]\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[8]\n";
			}
		}
	}
}

#if in     c
foreach my $i(keys %hash3){
	unless (exists $hash1{$i}) {
		unless (exists $hash2{$i}) {
			foreach my $j(keys %{$hash3{$i}}){
				print OUTFILE "$i\t$hash3{$i}{$j}[1]\t$j\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[8]\n";
			}
		}
	}
}
