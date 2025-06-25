#!/bin/bash

# Ask for username
read -p "Enter username to create: " USER

# Basic if-else structure using /etc/passwd for user check
if grep -q "^$USER:" /etc/passwd; then
  echo "User '$USER' already exists."
else
  sudo useradd -m "$USER"
  echo "User '$USER' created."
fi
