#! /usr/bin/bash

read -p "Enter the file extension (without the dot, e.g., txt):" extension
current_date=$(date +"%F")

read -p "Enter prefix to rename (leave this empty to use '$current_date'): " prefix

final_prefix=""

if [[ -z $prefix ]]; then
  final_prefix=$current_date
else
  final_prefix=$prefix
fi

files=(*.$extension)

if [ -z "${files[0]}" ]; then
  echo "0 .$extension files found in the current working directory"
  exit 1
fi

for file in "${files[@]}"; do
  new_name="${final_prefix}_${file}"
  echo "Renaming: $file -> $new_name"
  mv "$file" "$new_name"
done

echo "Renaming complete."
