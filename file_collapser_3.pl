#!/usr/bin/perl
#File collapser 3 - collapse by time (10min, 3hrs, 12hrs)

#	 perl file_collapser_3.pl 10min.txt 03hrs.txt 12hrs.txt final.txt

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

print OUTFILE "PeptideSequence\tProteinName\tPrecursorMz\tA10HTripletSum\tB10HTripletSum\tC10HTripletSum\tA10HFilename\tB10HFilename\tC10HFilename\tA10HFlag\tB10HFlag\tC10HFlag\tA10FTripletSum\tB10FTripletSum\tC10FTripletSum\tA10FFilename\tB10FFilename\tC10FFilename\tA10FFlag\tB10FFlag\tC10FFlag\tA03HTripletSum\tB03HTripletSum\tC03HTripletSum\tA03HFilename\tB03HFilename\tC03HFilename\tA03HFlag\tB03HFlag\tC03HFlag\tA03FTripletSum\tB03FTripletSum\tC03FTripletSum\tA03FFilename\tB03FFilename\tC03FFilename\tA03FFlag\tB03FFlag\tC03FFlag\tA12HTripletSum\tB12HTripletSum\tC12HTripletSum\tA12HFilename\tB12HFilename\tC12HFilename\tA12HFlag\tB12HFlag\tC12HFlag\tA12FTripletSum\tB12FTripletSum\tC12FTripletSum\tA12FFilename\tB12FFilename\tC12FFilename\tA12FFlag\tB12FFlag\tC12FFlag\n";

# PeptideSequence\tProteinName\tPrecursorMz\tA10HTripletSum\tB10HTripletSum\tC10HTripletSum\tA10HFilename\tB10HFilename\tC10HFilename\tA10HFlag\tB10HFlag\tC10HFlag\tA10FTripletSum\tB10FTripletSum\tC10FTripletSum\tA10FFilename\tB10FFilename\tC10FFilename\tA10FFlag\tB10FFlag\tC10FFlag\tA03HTripletSum\tB03HTripletSum\tC03HTripletSum\tA03HFilename\tB03HFilename\tC03HFilename\tA03HFlag\tB03HFlag\tC03HFlag\tA03FTripletSum\tB03FTripletSum\tC03FTripletSum\tA03FFilename\tB03FFilename\tC03FFilename\tA03FFlag\tB03FFlag\tC03FFlag\tA12HTripletSum\tB12HTripletSum\tC12HTripletSum\tA12HFilename\tB12HFilename\tC12HFilename\tA12HFlag\tB12HFlag\tC12HFlag\tA12FTripletSum\tB12FTripletSum\tC12FTripletSum\tA12FFilename\tB12FFilename\tC12FFilename\tA12FFlag\tB12FFlag\tC12FFlag\n

my %hash1;
while (<INFILE1>) {
	chomp;
	next if $_=~m/Peptide/;
	my @linedata1 = split(/\t/);
	my $peptide1 = $linedata1[0];
	my $precursor1 = $linedata1[2];
	$hash1{$peptide1}{$precursor1}= [@linedata1];
	# print "1\t$precursor1$peptide1\n";
}

my %hash2;
while (<INFILE2>) {
	chomp;
	next if $_=~m/Peptide/;
	my @linedata2 = split(/\t/);
	my $peptide2 = $linedata2[0];
	my $precursor2 = $linedata2[2];
	$hash2{$peptide2}{$precursor2}= [@linedata2];
	# print "2\t$precursor2\t$peptide2\n";
}

my %hash3;
while (<INFILE3>) {
	chomp;
	next if $_=~m/Peptide/;
	my @linedata3 = split(/\t/);
	my $peptide3 = $linedata3[0];
	my $precursor3 = $linedata3[2];
	$hash3{$peptide3}{$precursor3}= [@linedata3];
	# print "3\t$precursor3\t$peptide3\n";
}


# if in 10min 03hrs 12hrs
foreach my $i(keys %hash1){
	foreach my $j(keys %{$hash1{$i}}){
		if (exists $hash2{$i}{$j} && exists $hash3{$i}{$j}) {
			print OUTFILE " $i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[9]\t$hash1{$i}{$j}[15]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[10]\t$hash1{$i}{$j}[16]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[11]\t$hash1{$i}{$j}[17]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[12]\t$hash1{$i}{$j}[18]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[13]\t$hash1{$i}{$j}[19]\t$hash1{$i}{$j}[8]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[20]\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[9]\t$hash2{$i}{$j}[15]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[10]\t$hash2{$i}{$j}[16]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[11]\t$hash2{$i}{$j}[17]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[12]\t$hash2{$i}{$j}[18]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[13]\t$hash2{$i}{$j}[19]\t$hash2{$i}{$j}[8]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[20]\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[9]\t$hash3{$i}{$j}[15]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[10]\t$hash3{$i}{$j}[16]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[11]\t$hash3{$i}{$j}[17]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[12]\t$hash3{$i}{$j}[18]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[13]\t$hash3{$i}{$j}[19]\t$hash3{$i}{$j}[8]\t$hash3{$i}{$j}[14]\t$hash3{$i}{$j}[20]\n";
		}
	}
}




# $i\t$hash1{$i}{$j}[1]\t$j
# \t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[9]\t$hash1{$i}{$j}[15]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[10]\t$hash1{$i}{$j}[16]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[11]\t$hash1{$i}{$j}[17]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[12]\t$hash1{$i}{$j}[18]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[13]\t$hash1{$i}{$j}[19]\t$hash1{$i}{$j}[8]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[20]
# \t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[9]\t$hash2{$i}{$j}[15]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[10]\t$hash2{$i}{$j}[16]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[11]\t$hash2{$i}{$j}[17]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[12]\t$hash2{$i}{$j}[18]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[13]\t$hash2{$i}{$j}[19]\t$hash2{$i}{$j}[8]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[20]
# \t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[9]\t$hash3{$i}{$j}[15]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[10]\t$hash3{$i}{$j}[16]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[11]\t$hash3{$i}{$j}[17]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[12]\t$hash3{$i}{$j}[18]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[13]\t$hash3{$i}{$j}[19]\t$hash3{$i}{$j}[8]\t$hash3{$i}{$j}[14]\t$hash3{$i}{$j}[20]

#$i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[9]\t$hash1{$i}{$j}[15]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[10]\t$hash1{$i}{$j}[16]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[11]\t$hash1{$i}{$j}[17]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[12]\t$hash1{$i}{$j}[18]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[13]\t$hash1{$i}{$j}[19]\t$hash1{$i}{$j}[8]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[20]\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[9]\t$hash2{$i}{$j}[15]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[10]\t$hash2{$i}{$j}[16]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[11]\t$hash2{$i}{$j}[17]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[12]\t$hash2{$i}{$j}[18]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[13]\t$hash2{$i}{$j}[19]\t$hash2{$i}{$j}[8]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[20]\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[9]\t$hash3{$i}{$j}[15]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[10]\t$hash3{$i}{$j}[16]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[11]\t$hash3{$i}{$j}[17]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[12]\t$hash3{$i}{$j}[18]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[13]\t$hash3{$i}{$j}[19]\t$hash3{$i}{$j}[8]\t$hash3{$i}{$j}[14]\t$hash3{$i}{$j}[20]

# \tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA

# if in 10min 03hrs
foreach my $i(keys %hash1){
	foreach my $j(keys %{$hash1{$i}}){
		if (exists $hash2{$i}{$j}) {
			unless (exists $hash3{$i}{$j}) {
				print OUTFILE " $i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[9]\t$hash1{$i}{$j}[15]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[10]\t$hash1{$i}{$j}[16]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[11]\t$hash1{$i}{$j}[17]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[12]\t$hash1{$i}{$j}[18]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[13]\t$hash1{$i}{$j}[19]\t$hash1{$i}{$j}[8]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[20]\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[9]\t$hash2{$i}{$j}[15]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[10]\t$hash2{$i}{$j}[16]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[11]\t$hash2{$i}{$j}[17]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[12]\t$hash2{$i}{$j}[18]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[13]\t$hash2{$i}{$j}[19]\t$hash2{$i}{$j}[8]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[20]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
			}
		}
	}
}



# if in 10min 
foreach my $i(keys %hash2){
	foreach my $j(keys %{$hash1{$i}}){
		unless (exists $hash2{$i}{$j}) {
			unless (exists $hash3{$i}{$j}) {
				print OUTFILE " $i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[9]\t$hash1{$i}{$j}[15]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[10]\t$hash1{$i}{$j}[16]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[11]\t$hash1{$i}{$j}[17]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[12]\t$hash1{$i}{$j}[18]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[13]\t$hash1{$i}{$j}[19]\t$hash1{$i}{$j}[8]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[20]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
			}
		}
	}
}



#if in   03hrs 12hrs
foreach my $i(keys %hash2){
	foreach my $j(keys %{$hash2{$i}}){
		unless (exists $hash1{$i}{$j}) {
			if (exists $hash3{$i}{$j}) {
			print OUTFILE " $i\t$hash2{$i}{$j}[1]\t$j\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[9]\t$hash2{$i}{$j}[15]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[10]\t$hash2{$i}{$j}[16]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[11]\t$hash2{$i}{$j}[17]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[12]\t$hash2{$i}{$j}[18]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[13]\t$hash2{$i}{$j}[19]\t$hash2{$i}{$j}[8]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[20]\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[9]\t$hash3{$i}{$j}[15]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[10]\t$hash3{$i}{$j}[16]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[11]\t$hash3{$i}{$j}[17]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[12]\t$hash3{$i}{$j}[18]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[13]\t$hash3{$i}{$j}[19]\t$hash3{$i}{$j}[8]\t$hash3{$i}{$j}[14]\t$hash3{$i}{$j}[20]\n";
			}
		}
	}
}

# if in   03hrs
foreach my $i(keys %hash2){
	foreach my $j(keys %{$hash2{$i}}){
		unless (exists $hash1{$i}{$j}) {
			unless (exists $hash3{$i}{$j}) {
			print OUTFILE " $i\t$hash2{$i}{$j}[1]\t$j\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash2{$i}{$j}[3]\t$hash2{$i}{$j}[9]\t$hash2{$i}{$j}[15]\t$hash2{$i}{$j}[4]\t$hash2{$i}{$j}[10]\t$hash2{$i}{$j}[16]\t$hash2{$i}{$j}[5]\t$hash2{$i}{$j}[11]\t$hash2{$i}{$j}[17]\t$hash2{$i}{$j}[6]\t$hash2{$i}{$j}[12]\t$hash2{$i}{$j}[18]\t$hash2{$i}{$j}[7]\t$hash2{$i}{$j}[13]\t$hash2{$i}{$j}[19]\t$hash2{$i}{$j}[8]\t$hash2{$i}{$j}[14]\t$hash2{$i}{$j}[20]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
			}
		}
	}
}

# if in 10mins   12hrs
foreach my $i(keys %hash1){
	foreach my $j(keys %{$hash1{$i}}){
		if (exists $hash3{$i}{$j}) {
			unless (exists $hash2{$i}{$j}) {
				print OUTFILE " $i\t$hash1{$i}{$j}[1]\t$j\t$hash1{$i}{$j}[3]\t$hash1{$i}{$j}[9]\t$hash1{$i}{$j}[15]\t$hash1{$i}{$j}[4]\t$hash1{$i}{$j}[10]\t$hash1{$i}{$j}[16]\t$hash1{$i}{$j}[5]\t$hash1{$i}{$j}[11]\t$hash1{$i}{$j}[17]\t$hash1{$i}{$j}[6]\t$hash1{$i}{$j}[12]\t$hash1{$i}{$j}[18]\t$hash1{$i}{$j}[7]\t$hash1{$i}{$j}[13]\t$hash1{$i}{$j}[19]\t$hash1{$i}{$j}[8]\t$hash1{$i}{$j}[14]\t$hash1{$i}{$j}[20]\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[9]\t$hash3{$i}{$j}[15]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[10]\t$hash3{$i}{$j}[16]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[11]\t$hash3{$i}{$j}[17]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[12]\t$hash3{$i}{$j}[18]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[13]\t$hash3{$i}{$j}[19]\t$hash3{$i}{$j}[8]\t$hash3{$i}{$j}[14]\t$hash3{$i}{$j}[20]\n";
			}
		}
	}
}


# if in     12hrs
foreach my $i(keys %hash3){
	foreach my $j(keys %{$hash3{$i}}){
		unless (exists $hash1{$i}{$j}) {
			unless (exists $hash2{$i}{$j}) {
				print OUTFILE " $i\t$hash3{$i}{$j}[1]\t$j\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\t$hash3{$i}{$j}[3]\t$hash3{$i}{$j}[9]\t$hash3{$i}{$j}[15]\t$hash3{$i}{$j}[4]\t$hash3{$i}{$j}[10]\t$hash3{$i}{$j}[16]\t$hash3{$i}{$j}[5]\t$hash3{$i}{$j}[11]\t$hash3{$i}{$j}[17]\t$hash3{$i}{$j}[6]\t$hash3{$i}{$j}[12]\t$hash3{$i}{$j}[18]\t$hash3{$i}{$j}[7]\t$hash3{$i}{$j}[13]\t$hash3{$i}{$j}[19]\t$hash3{$i}{$j}[8]\t$hash3{$i}{$j}[14]\t$hash3{$i}{$j}[20]\n";
			}
		}
	}
}
