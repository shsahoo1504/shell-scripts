#!/bin/bash

# Ask user to choose whether to create a user or group
read -p "Do you want to create a user or a group? (user/group): " CHOICE

# Conditional branching
if [[ "$CHOICE" == "user" ]]; then
  read -p "Enter username: " USER
  sudo useradd -m "$USER"
  echo "User '$USER' created."

elif [[ "$CHOICE" == "group" ]]; then
  read -p "Enter group name: " GROUP
  sudo groupadd "$GROUP"
  echo "Group '$GROUP' created."

else
  # Handle invalid input
  echo "Invalid option."
fi
