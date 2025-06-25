#!/bin/bash

echo "Welcome to the User Creation Script"

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Prompt for multiple usernames
read -p "Enter usernames to create (space-separated): " -a USERNAMES

for USERNAME in "${USERNAMES[@]}"; do
  echo -e "\n--- Processing user: $USERNAME ---"

  # Validate username: must start with letter and contain only letters, digits, underscores, or hyphens
  if [[ ! "$USERNAME" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]]; then
    echo "Invalid username format: '$USERNAME'. Skipping."
    continue
  fi

  # Check if user already exists
  if grep -q "^$USERNAME:" /etc/passwd; then
    echo "User '$USERNAME' already exists. Skipping."
    continue
  fi

  # Ask for custom home directory
  read -p "Do you want a custom home directory for $USERNAME? (yes/no): " CUSTOM_HOME
  if [[ "$CUSTOM_HOME" == "yes" ]]; then
    read -p "Enter custom home path: " HOMEDIR
    HOME_FLAG="-d $HOMEDIR"
  else
    HOME_FLAG=""
  fi

  # Shell selection
  echo "Choose login shell for $USERNAME:"
  echo "1) /bin/bash"
  echo "2) /bin/sh"
  echo "3) /usr/sbin/nologin"
  read -p "Enter choice (1/2/3): " SHELL_CHOICE

  case "$SHELL_CHOICE" in
    1) SHELL="/bin/bash" ;;
    2) SHELL="/bin/sh" ;;
    3) SHELL="/usr/sbin/nologin" ;;
    *) echo "Invalid choice. Using default shell."; SHELL="/bin/bash" ;;
  esac

  # Group assignment
  read -p "Enter groups to assign $USERNAME (space-separated): " -a GROUPS
  VALID_GROUPS=()
  for GROUP in "${GROUPS[@]}"; do
    # Validate group name
    if [[ "$GROUP" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
      if grep -q "^$GROUP:" /etc/group; then
        echo "Group '$GROUP' exists."
      else
        echo "Group '$GROUP' does not exist. Creating it."
        if groupadd "$GROUP"; then
          echo "Group '$GROUP' created."
        else
          echo "Failed to create group '$GROUP'. Skipping."
          continue
        fi
      fi
      VALID_GROUPS+=("$GROUP")
    else
      echo "Invalid group name '$GROUP'. Skipping."
    fi
  done

  # Final group fallback
  if [ ${#VALID_GROUPS[@]} -eq 0 ]; then
    echo "No valid groups provided. Assigning to default group 'users'."
    VALID_GROUPS=("users")
    if ! grep -q "^users:" /etc/group; then
      groupadd users
    fi
  fi

  GROUP_CSV=$(IFS=, ; echo "${VALID_GROUPS[*]}")

  # Create user
  useradd -m $HOME_FLAG -s "$SHELL" -G "$GROUP_CSV" "$USERNAME"
  if grep -q "^$USERNAME:" /etc/passwd; then
    echo "User '$USERNAME' created with shell '$SHELL' and groups: ${VALID_GROUPS[*]}"
  else
    echo "Failed to create user '$USERNAME'."
  fi

done
