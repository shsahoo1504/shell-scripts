#!/bin/bash
sudo groupadd developers
sudo groupadd testers
sudo groupadd project_managers
sudo useradd -m -G developers john_doe
