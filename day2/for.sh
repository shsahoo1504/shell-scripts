#!/bin/bash

# Read space-separated group names into an array
read -p "Enter group names (space-separated): " -a group_list

# Loop through each group name
for group in "${group_list[@]}"
do
  # Check if group already exists in /etc/group
  if grep -q "^$group:" /etc/group; then
    echo "Group '$group' already exists."
  else
    # Create group if it does not exist
    sudo groupadd "$group"

    # Check if groupadd succeeded
    if [ $? -eq 0 ]; then
      echo "Group '$group' created."
    else
      echo "Failed to create group '$group'."
    fi
  fi
done
