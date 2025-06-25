#!/bin/bash

: ${1?"Usage: $0 <group1> <group2> <group3> <username>
  
Description:
  This script creates three user groups and one user.
  The user is created with a home directory and added to the first group.

Positional Parameters:
  group1     Name of the first group (user will be added to this group)
  group2     Name of the second group
  group3     Name of the third group
  username   Name of the user to be created

Example:
  $0 developers testers project_managers john_doe
"}

GROUP1=$1
GROUP2=$2
GROUP3=$3
USERNAME=$4

echo "Creating groups..."
sudo groupadd "$GROUP1"
echo "Group '$GROUP1' created."

sudo groupadd "$GROUP2"
echo "Group '$GROUP2' created."

sudo groupadd "$GROUP3"
echo "Group '$GROUP3' created."

echo "Creating user '$USERNAME' and adding to group '$GROUP1'..."
sudo useradd -m -G "$GROUP1" "$USERNAME"
echo "User '$USERNAME' created and added to group '$GROUP1'."

echo "Setup complete."

