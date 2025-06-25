#!/bin/bash

echo "Creating groups..."
sudo groupadd developers
echo "Group 'developers' created."

sudo groupadd testers
echo "Group 'testers' created."

sudo groupadd project_managers
echo "Group 'project_managers' created."

echo "Creating user 'john_doe' and adding to 'developers' group..."
sudo useradd -m -G developers john_doe
echo "User 'john_doe' created and added to 'developers' group."

echo "Setup complete."

