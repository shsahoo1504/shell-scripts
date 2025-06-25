#!/bin/bash

# Ask user for a username
read -p "Enter username: " USER

# Display shell options
echo "Choose shell:"
echo "1) /bin/bash"
echo "2) /bin/sh"
echo "3) /usr/sbin/nologin"

# Get user's shell choice
read -p "Enter choice [1-3]: " choice

# Decide shell based on user input using case
case "$choice" in
  1) shell="/bin/bash" ;;
  2) shell="/bin/sh" ;;
  3) shell="/usr/sbin/nologin" ;;
  *) echo "Invalid option. Using default shell."; shell="/bin/bash" ;;
esac

# Create the user with specified shell
sudo useradd -m -s "$shell" "$USER"
echo "User '$USER' created with shell '$shell'."
