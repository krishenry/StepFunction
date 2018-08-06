#!/bin/sh

declare -a lines
count=0
filename='lambdanames.txt'

while IFS='' read -r line || [[ -n "$line" ]]; do
	lines[${count}]=${line}
	count=$((count+1))
	
done < $filename

echo $count #correct number of lines in file

for ((i=0;i<=$count;i++)); do 
	variable_line_[$i]=${lines[$i]} 
	#variable_line=${variable_line_{$i}}
	echo "${variable_line_[$i][0]}"
done

variables_line0=( ${lines[0]} )
echo "${lines[0]}"
echo "${variables_line0[0]}"
echo "${variables_line0[1]}"
echo "${variables_line0[2]}"

variables_line1=( ${lines[1]} )
echo "${lines[1]}"
echo "${variables_line1[0]}"
echo "${variables_line1[1]}"
echo "${variables_line1[2]}"


#echo "(${$lines[1]}[0])"
#echo "${lines[1]}"