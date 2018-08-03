#!/bin/sh

filename='lambdanames.txt'
ls -al
chmod +x deployAlias.sh
while IFS='' read -r line || [[ -n "$line" ]]; do
	export line
	./deployAlias.sh #./deployTest 
done < $filename