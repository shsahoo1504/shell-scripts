#!/bin/bash

echo "Welcome to the User Creation Script"

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Prompt for username
read -p "Enter the username to create: " USERNAME
if grep -q "^$USERNAME:" /etc/passwd; then
  echo "User '$USERNAME' already exists."
  exit 1
fi

# Ask for custom home directory with validation
read -p "Do you want a custom home directory? (yes/no): " answer
if [[ "$answer" == "yes" ]]; then
  read -p "Enter custom home path: " HOMEDIR
  HOME_FLAG="-d $HOMEDIR"
elif [[ "$answer" == "no" ]]; then
  HOME_FLAG=""
else
  echo "Invalid input. Expected 'yes' or 'no'. Exiting."
  exit 1
fi

# Prompt to select shell with validation
echo "Choose shell:"
echo "1) /bin/bash"
echo "2) /bin/sh"
echo "3) /sbin/nologin"
read -p "Enter choice (1/2/3): " shell_choice

if [[ "$shell_choice" == "1" ]]; then
  SHELL="/bin/bash"
elif [[ "$shell_choice" == "2" ]]; then
  SHELL="/bin/sh"
elif [[ "$shell_choice" == "3" ]]; then
  SHELL="/sbin/nologin"
else
  echo "Invalid choice. Exiting."
  exit 1
fi

# Group creation/addition with validation
read -p "Do you want to add the user to an existing group? (yes/no): " grp_choice
if [[ "$grp_choice" == "yes" ]]; then
  read -p "Enter existing group name: " GROUP
  if grep -q "^$GROUP:" /etc/group; then
    echo "Using existing group '$GROUP'."
  else
    echo "Group '$GROUP' does not exist. Exiting."
    exit 1
  fi
elif [[ "$grp_choice" == "no" ]]; then
  read -p "Enter new group name to create: " GROUP
  if grep -q "^$GROUP:" /etc/group; then
    echo "Group '$GROUP' already exists."
  else
    groupadd "$GROUP" && echo "Group '$GROUP' created."
  fi
else
  echo "Invalid input. Expected 'yes' or 'no'. Exiting."
  exit 1
fi

# Create the user
useradd -m $HOME_FLAG -s "$SHELL" -G "$GROUP" "$USERNAME"

# Final status
if grep -q "^$USERNAME:" /etc/passwd; then
  echo "User '$USERNAME' created successfully with shell '$SHELL' and group '$GROUP'."
else
  echo "Failed to create user."
fi

