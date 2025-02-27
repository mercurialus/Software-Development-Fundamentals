#! /usr/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 input.csv"
  exit 1
fi

input_file="$1"

cp "$input_file" output.csv

while true; do
  echo ""
  echo "Choose an operation: "
  echo "1. Concatenate"
  echo "2. Sum"
  echo "3. Exit"
  read -p "Enter your choice: " choice

  case $choice in
  1)
    read -p "Enter the column numbers to concat (comma-separated): " cols

    new_header="Concat"
    IFS=',' read -ra arr <<<"$cols"
    for c in "${arr[@]}"; do
      new_header+="_c${c}"
    done
    awk -F, -v OFS="," -v cols="$cols" -v new_header="$new_header" '
        BEGIN {
          n = split(cols, a, ",")
        }
        NR==1 {
          print $0, new_header;
          next;
        }
        {
          result = "";
          for(i = 1; i <= n; i++){
            result = (result == "" ? $a[i] : result " " $a[i]);
          }
          print $0, result;
        }' output.csv >tmp && mv tmp output.csv
    continue
    ;;

  2)
    read -p "Enter column numbers to sum (comma-separated): " cols
    new_header="Sum"
    IFS=',' read -ra arr <<<"$cols"
    for c in "${arr[@]}"; do
      new_header+="_c${c}"
    done

    awk -F, -v OFS="," -v cols="$cols" -v new_header="$new_header" '
        BEGIN { split(cols, a, ","); }
        NR==1 {
        print $0, new_header;
        next;
      }
      {
        split(cols,a,",")
        sum = 0;
        for(i in a){
          sum += $a[i];
        }
        print $0, sum;
      }' output.csv >tmp && mv tmp output.csv
    ;;

  3)
    echo "Final output save to output.csv"
    exit 0
    ;;

  *)
    echo "Invalid choice. Please try again."
    ;;
  esac
done
