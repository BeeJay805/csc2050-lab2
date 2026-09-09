#!/usr/bin/env bash


if [ "$#" -ne 1 ]; then
	echo "Error: Please provide exactly one C file."
	exit 1
fi

file=$1

if [ ! -f "$file" ]; then
	echo "Error: File does not exist"
	exit 1
fi

if [[ "$file" != *.c ]]; then
	echo "Error: File must have a .c extension."
	exit 1
fi

filename=$(basename "$file")
owner=$(ls -l "$file" | awk '{ print $3 }')
modified=$(ls -l "$file" | awk '{ print $(NF-3), $(NF-2), $(NF-1) }')

temp_file=$(mktemp)

echo "/**" > "$temp_file"
echo " * File Name: $filename" >> "$temp_file"
echo " * Owner: $owner" >> "$temp_file"
echo " * Last Modified On: $modified" >> "$temp_file"
echo " */" >> "$temp_file"

cat "$file" >> "$temp_file"
mv "$temp_file" "$file"
