#!/bin/bash
# Reusable if user want to create multiple folder names.
#Author: sarath
#Date:********

#Accept folder name as input
foldername=$1

#check if a name was provided
if [ -z "$foldername" ]; then
  echo "usage: $0 <folder-name>"
  exit 1
fi

# Try to create the folder
if mkdir "$foldername" 2>/dev/null; then
  echo "Folder $foldername' created successfully."
else
  echo "could not create folder '$foldername'. May be it already exists?"
fi 