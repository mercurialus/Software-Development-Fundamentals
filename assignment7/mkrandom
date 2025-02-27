#! /usr/bin/bash

generate_random_file() {
  local filename="$1"
  local filesize="$2"

  dd if=/dev/urandom of="$filename" bs=1M count="$filesize" status=none
  echo "Created: $filename ($filesize MB)"
}

read -p "Enter the number of files to be generated:" num_files
read -p "Enter the size of each file (in MB): " file_size
output_dir=$(pwd)

if ! [[ "$num_files" =~ ^[0-9]+$ ]] || ! [[ "$file_size" =~ ^[0-9]+$ ]]; then
  echo "Error: Please enter valid numbers for both the number of files and size of file."
  exit 1
fi

for ((i = 1; i <= num_files; i++)); do
  generate_random_file "$output_dir/file_$i" "$file_size"
done

echo "All $num_files files created successfully in $output_dir"
