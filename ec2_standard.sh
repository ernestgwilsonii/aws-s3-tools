#!/bin/bash

# Start out fully patched
sudo yum upgrade -y

# Install standard tooling
sudo yum install -y htop
sudo yum install -y jq

# Add AWS EFS capability
sudo yum install -y amazon-efs-utils
sudo yum install -y nfs-utils

# Add Python modules
curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"
sudo python /tmp/get-pip.py
sudo pip install boto3 --upgrade
sudo pip install awsebcli --upgrade
