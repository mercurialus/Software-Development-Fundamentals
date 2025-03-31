#!/usr/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <csv_file> <column_number>"
  exit 1
fi

csv="$1"
col="$2"

if [ ! -f "$csv" ]; then
  echo "File not found: $csv"
  exit 1
fi

regex='^-?[0-9]+([.][0-9]+)?$'

fval=$(awk -F, -v col="$col" 'NR==1 {print $col}' "$csv")
sval=$(awk -F, -v col="$col" 'NR==2 {print $col}' "$csv")
tval=$(awk -F, -v col="$col" 'NR==3 {print $col}' "$csv")

if ! [[ "$fval" =~ $regex && "$sval" =~ $regex && "$tval" =~ $regex ]]; then
  echo "The values are not numeric"
  exit 1
fi

d1=$(echo "$sval - $fval" | bc -l)
d2=$(echo "$tval - $sval" | bc -l)

if [ "$(echo "$d1 == $d2" | bc -l)" -ne 1 ]; then
  echo "Values do not form an Arithmetic Progression."
  exit -1
fi

d="$d1"
lval=$(awk -F, -v col="$col" 'END {print $col}' "$csv")

read -rp "Please enter the number of rows to be filled: " rows
if ! [[ "$rows" =~ ^[0-9]+$ ]]; then
  echo "Invalid number of rows"
  exit 1
fi

num_cols=$(head -n 1 "$csv" | awk -F, '{print NF}')

for (( i=0 ; i<rows; i++ )); do
  lval=$(echo "$lval + $d" | bc -l)
  new_row=""
  
  for (( j=1; j<=num_cols; j++ )); do
    if [ "$j" -eq "$col" ]; then
      new_row="${new_row}${lval}"
    fi

    if [ "$j" -lt "$num_cols" ]; then
      new_row="${new_row},"
    fi
  done

  echo "$new_row" >> "$csv"
done

echo "CSV file updated."
