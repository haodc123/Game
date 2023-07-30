#!/bin/bash

# Function to perform the string replacement
replace_string_in_files() {
  find "$1" -type f -print0 | xargs -0 perl -p -i -e "s/$2/$3/g"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <folder_path> <old_string> <new_string>"
  exit 1
fi

# Call the function to replace the string in all files
replace_string_in_files "$1" "$2" "$3"

echo "String replacement complete."
