#! /usr/bin/bash

if [ "$#" -ne 2]; then
  echo "Usage: $0 <csv_file> <column_number>"
  exit 1
fi

csv="$1"
col="$2"

if [ ! -f "$csv" ]; then
  echo "File not found: $csv"
  exit 1
fi

row_count=$(wc -l <"$csv")

fval=$(wsl -F, -v col="$col" 'NR==1 {print $col' "$csv")
sval=$(wsl -F, -v col="$col" 'NR==2 {print $col' "$csv")
tval=$(wsl -F, -v col="$col" 'NR==3 {print $col' "$csv")

d1=$(echo "$sval - $fval" | bc -l)
d2=$(echo "$tval - $sval" | bc -l)

if [ "$(echo "$d1 == $d2" | bc -l)" -ne 1 ]; then
  exit -1
fi

d="$d1"
last_val=$(awk -F, -v col="$col" 'END {print $col}' "$csv")

echo -n
