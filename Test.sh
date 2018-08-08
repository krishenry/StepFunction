#!/bin/sh

echo "hi"
filename='lambdanames.txt'
count=0

declare alias
declare	lambda_names
declare version

while IFS='' read -r line || [[ -n "$line" ]]; do
	variables=( $line )
	
	alias[${count}]="${variables[2]}"
	echo "${alias[${count}]}"

	version[${count}]="${variables[1]}"
	echo "${version[${count}]}"

	lambda_names[${count}]="${variables[0]}"
	echo "${lambda_names[${count}]}"

	count=$((count+1))
done < $filename

echo "end"
