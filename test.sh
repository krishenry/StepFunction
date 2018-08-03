#!/bin/sh

filename='lambdanames.txt'
chmod +x deployAlias.sh
while IFS='' read -r line || [[ -n "$line" ]]; do
	export line
	#./splitterfunctiontest.sh 
	./deployAlias.sh
done < $filename