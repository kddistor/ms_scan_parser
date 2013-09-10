#!/usr/bin/perl
#MS Scan file splitter - Splits the file into smaller files to process

use strict;
use warnings;

# die "<Input>" unless @ARGV==1;
#perl scanms_splitter.pl ABC10minx.txt ABC03hrsx.txt ABC12hrsx.txt

my $tenmin = $ARGV[0];
my $threehrs = $ARGV[1];
my $twelvehrs = $ARGV[2];

open (MASTER10MIN, "<$tenmin") or die 'File cannot be opened\n\n';
open FILE1, '>A10F.text' or die 'File cannot be opened\n\n';
open FILE2, '>A10H.text' or die 'File cannot be opened\n\n';
open FILE3, '>B10F.text' or die 'File cannot be opened\n\n';
open FILE4, '>B10H.text' or die 'File cannot be opened\n\n';
open FILE5, '>C10F.text' or die 'File cannot be opened\n\n';
open FILE6, '>C10H.text' or die 'File cannot be opened\n\n';
open (MASTER03HRS, "<$threehrs") or die 'File cannot be opened\n\n';
open FILE7, '>A03F.text' or die 'File cannot be opened\n\n';
open FILE8, '>A03H.text' or die 'File cannot be opened\n\n';
open FILE9, '>B03F.text' or die 'File cannot be opened\n\n';
open FILE10, '>B03H.text' or die 'File cannot be opened\n\n';
open FILE11, '>C03F.text' or die 'File cannot be opened\n\n';
open FILE12, '>C03H.text' or die 'File cannot be opened\n\n';
open (MASTER12HRS, "<$twelvehrs") or die 'File cannot be opened\n\n';
open FILE13, '>A12F.text' or die 'File cannot be opened\n\n';
open FILE14, '>A12H.text' or die 'File cannot be opened\n\n';
open FILE15, '>B12F.text' or die 'File cannot be opened\n\n';
open FILE16, '>B12H.text' or die 'File cannot be opened\n\n';
open FILE17, '>C12F.text' or die 'File cannot be opened\n\n';
open FILE18, '>C12H.text' or die 'File cannot be opened\n\n';

my $firstline = <MASTER10MIN>;
print FILE1 "$firstline";
print FILE2 "$firstline";
print FILE3 "$firstline";
print FILE4 "$firstline";
print FILE5 "$firstline";
print FILE6 "$firstline";
print FILE7 "$firstline";
print FILE8 "$firstline";
print FILE9 "$firstline";
print FILE10 "$firstline";
print FILE11 "$firstline";
print FILE12 "$firstline";
print FILE13 "$firstline";
print FILE14 "$firstline";
print FILE15 "$firstline";
print FILE16 "$firstline";
print FILE17 "$firstline";
print FILE18 "$firstline";


foreach  my $line (<MASTER10MIN>){
	next if $line=~m/peptide/;
	my @linedata=split(/\t/,$line);

	# get replicate name
	my $replicate_name=$linedata[12];
	# get precursor line
	my $precursor_column=$linedata[8];

	
	if ($replicate_name eq 'A10F' && $precursor_column eq 'precursor') {chomp $line; print FILE1 "$line\n"; }
	if ($replicate_name eq 'A10H' && $precursor_column eq 'precursor') {chomp $line; print FILE2 "$line\n"; }
	if ($replicate_name eq 'B10F' && $precursor_column eq 'precursor') {chomp $line; print FILE3 "$line\n"; }
	if ($replicate_name eq 'B10H' && $precursor_column eq 'precursor') {chomp $line; print FILE4 "$line\n"; }
	if ($replicate_name eq 'C10F' && $precursor_column eq 'precursor') {chomp $line; print FILE5 "$line\n"; }
	if ($replicate_name eq 'C10H' && $precursor_column eq 'precursor') {chomp $line; print FILE6 "$line\n"; }
}

foreach  my $line (<MASTER03HRS>){
	next if $line=~m/peptide/;
	my @linedata=split(/\t/,$line);

	# get replicate name
	my $replicate_name=$linedata[12];
	# get precursor line
	my $precursor_column=$linedata[8];

	
	if ($replicate_name eq 'A03F' && $precursor_column eq 'precursor') {chomp $line; print FILE7 "$line\n"; }
	if ($replicate_name eq 'A03H' && $precursor_column eq 'precursor') {chomp $line; print FILE8 "$line\n"; }
	if ($replicate_name eq 'B03F' && $precursor_column eq 'precursor') {chomp $line; print FILE9 "$line\n"; }
	if ($replicate_name eq 'B03H' && $precursor_column eq 'precursor') {chomp $line; print FILE10 "$line\n"; }
	if ($replicate_name eq 'C03F' && $precursor_column eq 'precursor') {chomp $line; print FILE11 "$line\n"; }
	if ($replicate_name eq 'C03H' && $precursor_column eq 'precursor') {chomp $line; print FILE12 "$line\n"; }
}

foreach  my $line (<MASTER12HRS>){
	next if $line=~m/peptide/;
	my @linedata=split(/\t/,$line);

	# get replicate name
	my $replicate_name=$linedata[12];
	# get precursor line
	my $precursor_column=$linedata[8];

	
	if ($replicate_name eq 'A12F' && $precursor_column eq 'precursor') {chomp $line; print FILE13 "$line\n"; }
	if ($replicate_name eq 'A12H' && $precursor_column eq 'precursor') {chomp $line; print FILE14 "$line\n"; }
	if ($replicate_name eq 'B12F' && $precursor_column eq 'precursor') {chomp $line; print FILE15 "$line\n"; }
	if ($replicate_name eq 'B12H' && $precursor_column eq 'precursor') {chomp $line; print FILE16 "$line\n"; }
	if ($replicate_name eq 'C12F' && $precursor_column eq 'precursor') {chomp $line; print FILE17 "$line\n"; }
	if ($replicate_name eq 'C12H' && $precursor_column eq 'precursor') {chomp $line; print FILE18 "$line\n"; }
}
