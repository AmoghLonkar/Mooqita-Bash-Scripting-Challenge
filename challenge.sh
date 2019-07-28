#!/bin/bash

#Master string of eligible characters
masterString="ABCDEFJHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#Remove file if it previously existed 
if [ -e line.txt ]  || [ - e line_wo_a.txt ] 
then 
	#deleting if file already exists
	rm -f line.txt line_wo_a.txt
fi

#creating text file
touch line.txt
size=$(wc -c < "line.txt")

#Specifying max file size to be 1K
maxFileSize=1024

#generating lines of 15 characters...
while [ $size -lt $maxFileSize ]
do
	for i in $(seq 1 15)	
	do 
		#pick random index between 0 and 61
		index=$(expr $RANDOM % 62)
		#Picking character from string using random index
		char=${masterString:index:1}
		
		#concatenate 15 random characters to form a line
		line+=$char
	done

	#Appending randomly generated line to text file
	echo "$line" >> line.txt
			
	#Calculating size of file post-appending
	size=$(wc -c < "line.txt")	
	
	#Resetting line to empty string to accomodate new characters
	line=""
done

#Once file is completely populated...
		
#Sorting file
sort line.txt >> line.txt
		
#Finding all lines not starting with 'a' or 'A'
#and sending them to a new text file	
grep -v -i "^a" line.txt > lines_wo_a.txt
	
#Counting number of lines
originalLines=$(wc -l < "line.txt")
newLines=$(wc -l < "lines_wo_a.txt")
	
removedLines=$(($originalLines-newLines))
	
#Displaying to console for clarity
echo "Lines in original file starting with a or A: "
grep -i "^a" line.txt
echo "Total lines removed in new file: $removedLines"
		






