# Remove multiple boundaries in a Praat TextGrid file
#
# This script removes all boundaries within a TextGrid between a selected
# start and endpoint. Before running this script, determine the first and
# last boundaries to be removed in a selection from a particular tier. If
# more than one selection or tier is to be removed, run this script multiple
# times, once for each tier or section. 
#
# 1.11.2017
# Richard Hatcher
#

#Ask the user for the input file and which tier and intervals to erase
form Provide the file, tier and intervals that should be removed
	text file file
	integer tier 1
	integer begin 1
	integer end 2
endform

#Read in the file provided.
Read from file: file$

#For each interval selected remove the right boundary. The beginning and end are the respective boundary
#numbers.
for intervalNumber from (begin - 1) to (end - 1)
	Remove right boundary... tier begin
endfor
#Removes any labels from the removed intervals.
Set interval text... tier begin 
