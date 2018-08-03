#!/bin/sh

filename='lambdanames.txt'
while IFS='' read -r line || [[ -n "$line" ]]; do
	export line
	ls -al
	chmod +x deployAlias.sh
	ls -al
	./deployAlias.sh #./deployTest 
done < $filename