#!/usr/bin/perl
#Triplet sum getter - get triplet sums for the peptide that was most identified in the filename on a per peptide basis.


# perl adder_msscan.pl A10H.text A10H.protein A10H.text.added A10H.final

use strict;
use warnings;

my $infile1 = $ARGV[0];
my $infile2 = $ARGV[1];
my $outfile1 = $ARGV[2];
my $outfile2 = $ARGV[3];

#perl adder_msscan.pl $FILE.text $FILE.protein $FILE.added
# perl test.pl A10H.text A10H.protein A10H.text.added A10H.final

#Declare files
open (INFILE1, "<$infile1") or die 'File cannot be opened\n\n';
open (INFILE2, "<$infile2") or die 'File cannot be opened\n\n';
open (TEMP, ">temp.txt") or die 'File cannot be opened \n\n';
open (OUTFILE1, ">$outfile1") or die 'File cannot be opened\n\n';
open (OUTFILE2, ">$outfile2") or die 'File cannot be opened\n\n';

my $firstline1 = <INFILE1>;
chomp $firstline1;
print TEMP "$firstline1\tTotalIonIntensity\tTotalTripletSum\n";

my @file=<INFILE1>;
my @filtered_file=();

foreach  my $line (@file){
	next if $line=~m/PeptideSequence/;
	push(@filtered_file,$line); 
}

#for each processed file(file without precursor isotopes/all scans), get the total ion intensity
#and add to end of table. total_ion_intensity = total_area - total_background
#Store this new file in temp.txt
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
	print TEMP $line unless $line=~m/^\t\n/;
}
close (TEMP);

#Open temp.txt 
open (TEMP, "<temp.txt") or die 'File cannot be opened \n\n';
my $firstline2 = <TEMP>;
chomp $firstline2;
print OUTFILE1 "$firstline2\tTripletFlagged\tFlagged\n";
print OUTFILE2 "$firstline2\tTripletFlagged\tFlagged\n";
my $this_line = "";
my $last_line="";
my $next_sum;
my $sum_all;
my @temp_array;


#Get triplet sums for each line. Get identification for thre lines.  All triplet sums and ids are printed to $file.text.added file
#Algorithm: Takes current line and the last two lines. Prints the triplet sum and ids to middle line
while(<TEMP>) {
	chomp;
	my $lastlast_line = $last_line;
	my @linedata3=split(/\t/,$lastlast_line);
	my $lastlast_sum = $linedata3[19];
	my $lastlast_id = $linedata3[16];
	my $lastlast_filename = $linedata3[14]; 
    $last_line = $this_line;
	my @linedata1=split(/\t/,$last_line);
	my $last_sum = $linedata1[19];
	my $last_id = $linedata1[16];
	my $last_filename = $linedata1[14];
    $this_line = $_;
	my @linedata2=split(/\t/,$this_line);
	my $this_sum = $linedata2[19];
	my $this_id = $linedata2[16];
	my $this_filename = $linedata1[14];
	if (defined $last_line && $lastlast_line ne '' && defined $last_line && $last_line ne '' && defined $this_line && $this_line ne '') {
		if ($this_filename eq 'qex02192012_01.raw'){
			$sum_all = $last_sum + $lastlast_sum;
			if ($lastlast_id eq 'TRUE' || $last_id eq 'TRUE' || $this_id eq 'TRUE') {
				my $id = 'TRUE';
				print OUTFILE1 "$last_line\t$sum_all\t$lastlast_id,$last_id,$this_id\t$id\n";
			} else {
				my $id = 'FALSE';
				print OUTFILE1 "$last_line\t$sum_all\t$lastlast_id,$last_id,$this_id\t$id\n";
			}
		}
		if ($this_filename eq 'qex02192012_15.raw'){
			$sum_all = $last_sum + $this_sum;
			if ($lastlast_id eq 'TRUE' || $last_id eq 'TRUE' || $this_id eq 'TRUE') {
				my $id = 'TRUE';
				print OUTFILE1 "$last_line\t$sum_all\t$lastlast_id,$last_id,$this_id\t$id\n";
			} else {
				my $id = 'FALSE';
				print OUTFILE1 "$last_line\t$sum_all\t$lastlast_id,$last_id,$this_id\t$id\n";
			}
		} else {
			$sum_all = $last_sum + $this_sum + $lastlast_sum;
				if ($lastlast_id eq 'TRUE' || $last_id eq 'TRUE' || $this_id eq 'TRUE') {
				my $id = 'TRUE';
				print OUTFILE1 "$last_line\t$sum_all\t$lastlast_id,$last_id,$this_id\t$id\n";
			} else {
				my $id = 'FALSE';
				print OUTFILE1 "$last_line\t$sum_all\t$lastlast_id,$last_id,$this_id\t$id\n";
			}
		}
	}		
}
close (OUTFILE1);

open (OUTFILE1, "<$outfile1") or die 'File cannot be opened\n\n';

my @file1=<OUTFILE1>; #added file
my @file2=<INFILE2>; #protein

#Open $file.text.added. Open .protein file name containing all protein and slices that were identified the most. 
#If combinations matches in the $file.text.added file, print it to the $file.final file
for my $j (0..$#file2){
	my ($protein, $filename) = split(/\t/,$file2[$j]);
	chomp $filename;
	# print "$protein\t$filename\n";
	for my $i (0..$#file1){
		chomp $file1[$i];
		my @linedata4=split(/\t/,$file1[$i]);
		my $add_protein = $linedata4[1];
		my $add_filename = $linedata4[14];
		my $identified_added = $linedata4[13];
			# print "$add_protein\t$add_filename\n";
			if ($protein eq $add_protein && $filename eq $add_filename) {
				print OUTFILE2 "$file1[$i]\n";
			} elsif ($identified_added eq 'TRUE') {
				print OUTFILE2 "$file1[$i]\n";
			}
		}
}
