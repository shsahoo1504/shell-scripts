# User Creation Script – Bash Automation

## Purpose

This script is designed to **interactively create a Linux user** with customizable options such as:
- Custom or default home directory
- Preferred login shell
- Group membership (existing or newly created)

It helps streamline user provisioning with basic input validation and safety checks.

---

## Features

- Ensures the script is executed with root privileges
- Prompts for a unique username and checks against `/etc/passwd`
- Offers optional custom home directory
- Presents a menu to choose a login shell
- Supports assigning the user to an existing or newly created group
- Combines all parameters into a single `useradd` operation

---

## Bash Constructs Used

| Construct       | Purpose                                       |
|----------------|-----------------------------------------------|
| `if-else`       | Root check, username existence, group logic  |
| `if-elif-else`  | Home directory decision                      |
| `case`          | Shell selection                              |
| `grep`          | User and group existence checks              |

---

## Example Execution

```bash
$ sudo ./condition.sh
Welcome to the User Creation Script
Enter the username to create: alice
Do you want a custom home directory? (yes/no): yes
Enter custom home path: /opt/alice_home
Choose shell:
1) /bin/bash
2) /bin/sh
3) /sbin/nologin
Enter choice (1/2/3): 1
Do you want to add the user to an existing group? (yes/no): no
Enter new group name to create: devs
Group 'devs' created.
User 'alice' created successfully with shell '/bin/bash' and group 'devs'.

