#!/bin/bash

directory="$1"

# Retrieve the modification dates of files in the directory
find "$directory" -type f -printf "%T@\n" > dates.txt

# Sort the dates in ascending order
sort -n dates.txt > sorted_dates.txt
sort -n -r dates.txt > reverse_sorted_dates.txt

# Get the minimum and maximum dates using sed to extract a line number, gettig rid of outliers
min_date=$(sed '50q;d' sorted_dates.txt)
max_date=$(sed '100q;d' reverse_sorted_dates.txt)
average=$(awk '{x+=$0}END{print x/NR}' dates.txt)
average=$(printf "%.0f" $average)

# Convert the timestamps to human-readable format
min_date_formatted=$(date -d @$min_date '+%Y-%m-%d')
max_date_formatted=$(date -d @$max_date '+%Y-%m-%d')
avg_date_formatted=$(date -d @$average '+%Y-%m-%d')

# Display the date range
echo "The date range of files in $directory is $min_date_formatted to $max_date_formatted."
echo "The average date is $avg_date_formatted"

#copy date range to clipboard
echo $min_date_formatted to $max_date_formatted | xsel --clipboard --input

# Clean up temporary files
rm dates.txt sorted_dates.txt reverse_sorted_dates.txt
