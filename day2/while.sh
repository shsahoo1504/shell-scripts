#!/bin/bash

# Loop until a new user is successfully created
while true; do
  read -p "Enter a username: " USER

  # Check if user exists
  if grep -q "^$USER:" /etc/passwd; then
    echo "User '$USER' already exists. Try another."
  else
    # Try to create user
    sudo useradd -m "$USER"

    # Check creation status
    if [ $? -eq 0 ]; then
      echo "User '$USER' created successfully."
    else
      echo "Failed to create user '$USER'."
    fi
    break  # Exit loop once user is created
  fi
done
