#!/bin/sh

filename='lambdanames.txt'
chmod +x deployAlias.sh
while IFS='' read -r line || [[ -n "$line" ]]; do
	export line
	./deployAlias.sh
done < $filename