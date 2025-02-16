#!/usr/bin/env bash

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then 
  echo "Usage: $0 <monitor_directory> <backup_directory>"
  exit 1
fi  

# Assign the values to the variables for easy access later
MONITOR_DIR="$1"
BACKUP_DIR="$2"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Inform the user about the directories used  
echo "Monitoring Directory: $MONITOR_DIR"
echo "Backup Directory: $BACKUP_DIR"
echo "Type <exit> and press Enter to stop the script"

# Declare an associative array to store the last modification time of each file
declare -A last_mod_time

# Main Loop: Continuous Monitoring
while true; do
  # Check if the user typed 'exit'
  if read -t 0.1 -r user_input; then
    if [ "$user_input" = "exit" ]; then
      echo "Exiting the backup utility"
      break 
    fi
  fi

  # Loop over each file in the monitored directory
  for file in "$MONITOR_DIR"/*; do
    # Only process regular files
    if [ -f "$file" ]; then
      # Get the current modification time using stat
      current_mtime=$(stat -c %Y "$file")

      # If this file is seen for the first time, store its modification time
      if [ -z "${last_mod_time[$file]}" ]; then
        last_mod_time["$file"]=$current_mtime

      # If the file has been modified...
      elif [ "$current_mtime" -gt "${last_mod_time["$file"]}" ]; then
        # Create a timestamp for the backup filename
        timestamp=$(date +%Y%m%d_%H%M%S)
        backup_file="${BACKUP_DIR}/$(basename "$file")_${timestamp}"

        # Copy the modified file to the backup directory
        cp "$file" "$backup_file"
        echo "Backup created for file: $backup_file at time $timestamp"

        # Update the stored modification time
        last_mod_time["$file"]=$current_mtime
      fi
    fi
  done

  # Pause for a short while before checking again
  sleep 1
done
