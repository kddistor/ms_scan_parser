ms_scan_parser
==============

This script takes in MSScan data and produces a table where peptides are ranked according to triplet sum for the experiment and protein. 

READ_ME - MS Scan data parser
by Kevin Distor
University of California - Davis


This script takes in MSScan data by experiment (ie ABC10minx.txt) and produces a table where peptides	
are ranked according to triplet sum for the experiment and protein. 									


Scripts: 
1. scanms_splitter.pl				#splits file into different treatment, time period, replicates. 18 total
2. msscan_parser.pl					#filters the split files to only have precursors. Also generates a new column, Total Ion Current.
3. proteincounter_msscan.pl			#counts the number of protein and identfied filename combinations.
4. protein_collapser.pl				#grabs only the largest identified filenames from the proteins.
5. adder_msscan.pl					#gets the triplet sum for the current for each peptide. Also returns identification of file name.
6. file_collapser_1.pl				#collapses file by type (flg or h20)
7. file_collapser_1.pl				#collapses file by replicate (rep1, rep2, rep3)
8. file_collapser_1.pl				#collapses file by time (10min, 3hrs, 12hrs)
9. bash_MSScan_parser.sh			#shell script to automate 1-8. This is where you input parameters and specify input files and output names.													

##Modifications to files/scripts before using:
	Input file
		Open file in Excel:
			-Make sure number formats are in decimals (no scientific notation)
			-save as (.txt tab delimited format)
		Open file in Notepad++:
			-Convert end of line to UNIX format. Open in Notepad++. Go to Edit -> EOL Conversion -> UNIX/Mac
			-save
	bash_MSScan_parser.sh
		line 3,4,5 - specify infiles
		
##Dependencies:
	-All scripts and input files have to be in the same directory.
	-Directory should be void of any .text, .out, and .final files that you don't want to be deleted

##(tentative) After pipeline is run:
	-open final.txt in Excel
		-Search and replace "NA" with "0" (match case ticked);
		-Add columns after every XXXTripletSum column.
		-Label added columns XXXTripletSumRank
		-Go to Data->Sort
			-Add Level Sort by "ProteinName". Sort on "Values". Order "A to Z".
			-Add Level Sort by "XXXTripletSum". Sort on "Values". Order "Smallest to Largest".
		-In the first empty cell of XXXTripletSumRank:
			-type in formula: =SUMPRODUCT(($B$2:$B$6154=B2)*($Y$2:$Y$6154<Y2))+1
				-where Y is the column of XXXTripletSum
				-Apply this to the rest of the column
		-Repeat this process for all XXXTripletSumRank columns
