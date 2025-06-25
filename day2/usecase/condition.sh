#!/bin/bash

echo "Welcome to the User Creation Script"

# 1. if-else: Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
else
  echo "Running as root."
fi

# 2. while loop: Prompt until a valid username is given
while true; do
  read -p "Enter the username to create: " USERNAME
  if grep -q "^$USERNAME:" /etc/passwd; then
    echo "User '$USERNAME' already exists. Try another."
  else
    break
  fi
done

# 3. if-elif-else: Ask for home directory
read -p "Do you want a custom home directory? (yes/no): " answer
if [[ "$answer" == "yes" ]]; then
  read -p "Enter custom home path: " HOMEDIR
  CREATE_CMD="useradd -m -d $HOMEDIR $USERNAME"
elif [[ "$answer" == "no" ]]; then
  CREATE_CMD="useradd -m $USERNAME"
else
  echo "Invalid choice. Using default home directory."
  CREATE_CMD="useradd -m $USERNAME"
fi

# 4. case: Choose default shell
echo "Choose shell:"
echo "1) /bin/bash"
echo "2) /bin/sh"
echo "3) /sbin/nologin"
read -p "Enter choice (1/2/3): " shell_choice

case $shell_choice in
  1) SHELL="/bin/bash" ;;
  2) SHELL="/bin/sh" ;;
  3) SHELL="/sbin/nologin" ;;
  *) SHELL="/bin/bash" ;;
esac

# Append shell to command
CREATE_CMD+=" -s $SHELL"

# 5. for loop: Create multiple groups
read -p "Enter groups to create (space-separated): " -a GROUPS

for group in "${GROUPS[@]}"
do
  if grep -q "^$group:" /etc/group; then
    echo "Group '$group' already exists."
  else
    groupadd "$group"
    echo "Group '$group' created."
  fi
done

# Join groups for user creation
GROUP_LIST=$(IFS=, ; echo "${GROUPS[*]}")
CREATE_CMD+=" -G $GROUP_LIST"

# Create the user
echo "Creating user with command:"
echo "$CREATE_CMD"
eval "$CREATE_CMD"

# Final check using /etc/passwd instead of id
if grep -q "^$USERNAME:" /etc/passwd; then
  echo "User '$USERNAME' successfully created with groups: $GROUP_LIST and shell: $SHELL"
else
  echo "Failed to create user."
fi

