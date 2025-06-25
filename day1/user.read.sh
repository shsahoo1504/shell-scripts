#!/bin/bash

read -p "Enter the first group name: " GROUP1
read -p "Enter the second group name: " GROUP2
read -p "Enter the third group name: " GROUP3
read -p "Enter the username to create: " USERNAME

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

