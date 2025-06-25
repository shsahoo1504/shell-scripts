#!/bin/bash

# Ask for username
read -p "Enter username to create: " USER

# Check if user exists in /etc/passwd
if grep -q "^$USER:" /etc/passwd; then
  echo "User '$USER' already exists."
else
  echo "User '$USER' does not exist. Creating now..."

  # Attempt to create user
  sudo useradd -m "$USER"

  # Check if useradd succeeded
  if [ $? -eq 0 ]; then
    echo "User '$USER' created successfully."
  else
    echo "Failed to create user '$USER'."
  fi
fi
