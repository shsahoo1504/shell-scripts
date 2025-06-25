# User Creation Script – Multi-User Setup Automation

## Purpose

This script automates the creation of **one or more users** in a Linux system with options for:
- Custom home directory
- Shell selection
- Group membership (with group creation if needed)

---

## Features

- Accepts multiple usernames in one run
- Validates usernames and group names for format compliance
- Prompts interactively for:
  - Home directory setup
  - Shell selection (`/bin/bash`, `/bin/sh`, `/usr/sbin/nologin`)
  - Group assignment (existing or new)
- Creates valid groups if not found
- Adds user to `users` group if no valid group is assigned
- Reports success/failure after each user is processed

---

## Example Usage

```bash
$ sudo ./condition.sh
Welcome to the User Creation Script
Enter usernames to create (space-separated): alice bob

--- Processing user: alice ---
Do you want a custom home directory for alice? (yes/no): yes
Enter custom home path: /home/custom_alice
Choose login shell for alice:
1) /bin/bash
2) /bin/sh
3) /usr/sbin/nologin
Enter choice (1/2/3): 1
Enter groups to assign alice (space-separated): dev qa
Group 'dev' does not exist. Creating it.
Group 'qa' does not exist. Creating it.
User 'alice' created with shell '/bin/bash' and groups: dev,qa

--- Processing user: bob ---
Do you want a custom home directory for bob? (yes/no): no
Choose login shell for bob:
1) /bin/bash
2) /bin/sh
3) /usr/sbin/nologin
Enter choice (1/2/3): 3
Enter groups to assign bob (space-separated): !nv@lid group123
Group '!nv@lid' is not a valid group name. Skipping.
Group 'group123' does not exist. Creating it.
User 'bob' created with shell '/usr/sbin/nologin' and groups: group123

