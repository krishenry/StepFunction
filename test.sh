#!/bin/sh

filename='lambdanames.txt'
while IFS='' read -r line || [[ -n "$line" ]]; do
	export line
	./deployAlias #./deployTest #$line

done < $filename