# 🧑‍💻 User Creation Script – Bash Automation

## 📌 Purpose

This script is a comprehensive utility designed to **interactively create a Linux user** with customizable options including:
- Home directory
- Default login shell
- Group membership (with optional group creation)

It serves both as a **real-world automation tool** and a **teaching aid** to demonstrate Bash scripting fundamentals.

---

## 🔧 Features

- Checks if the script is run as `root`
- Accepts a unique username input with validation against `/etc/passwd`
- Offers custom or default home directory setup
- Allows selection from predefined shell options
- Creates one or more user groups dynamically if they don't already exist
- Combines all options into a final `useradd` command

---

## 💡 Use Case

This script is suitable for:
- **System administrators** who want to quickly onboard users with controlled configurations
- **DevOps and training workshops** where learners practice conditionals, loops, and command construction in Bash
- **IT teams** setting up structured Linux accounts with consistent group policies

---

## 🧪 Bash Constructs Demonstrated

| Construct       | Purpose                                  |
|----------------|-------------------------------------------|
| `if-else`       | Ensure the script runs with root privileges |
| `while` loop    | Keep prompting until a non-existing username is entered |
| `if-elif-else`  | Decide between custom and default home directory |
| `case`          | Select the shell interactively           |
| `for` loop      | Handle multiple group creation           |
| `eval`          | Dynamically execute the assembled `useradd` command |

---

## 🖥️ Example Execution

```bash
$ sudo ./user-create.sh
Welcome to the User Creation Script
Running as root.
Enter the username to create: alice
Do you want a custom home directory? (yes/no): yes
Enter custom home path: /opt/alice_home
Choose shell:
1) /bin/bash
2) /bin/sh
3) /sbin/nologin
Enter choice (1/2/3): 1
Enter groups to create (space-separated): dev qa
Group 'dev' created.
Group 'qa' created.
Creating user with command:
useradd -m -d /opt/alice_home -s /bin/bash -G dev,qa alice
User 'alice' successfully created with groups: dev,qa and shell: /bin/bash

