#!/bin/bash

# Start out fully patched
sudo yum upgrade -y

# Install standard tooling
sudo yum install -y git htop jq lsof mtr telnet

# Add AWS EFS capability
# Full EFS walk-through REF: https://docs.aws.amazon.com/efs/latest/ug/wt1-getting-started.html
# Just the mount commands REF: https://docs.aws.amazon.com/efs/latest/ug/wt1-test.html#wt1-mount-fs-and-test
sudo yum install -y amazon-efs-utils nfs-utils

# Install AWS CloudWatch monitoring requirements (adds memory and disk metrics)
# REF: https://tecadmin.net/monitor-memory-disk-metrics-ec2-linux/
sudo yum install -y perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA unzip zip
cd /opt
sudo wget  http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip
sudo unzip CloudWatchMonitoringScripts-1.2.1.zip
sudo rm -f /opt/CloudWatchMonitoringScripts-1.2.1.zip
# Command line verifications:
#/opt/aws-scripts-mon/mon-put-instance-data.pl --mem-util --verify --verbose
#/opt/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --verbose
# AWS EC2 IAM Role requires "put" access to CloudWatch "cloudwatch:PutMetricData" (do not hard code creds in a file)
# Add to crontab when ready to collect disk space and memory:
#*/5 * * * * /opt/aws-scripts-mon/mon-put-instance-data.pl --mem-used-incl-cache-buff --mem-util --disk-space-util --disk-path=/ --from-cron

# ECS CLI
# REF: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_installation.html
# For Linux systems:
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
sudo chmod +x /usr/local/bin/ecs-cli
#ecs-cli --version

# Docker
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
#sudo docker version

# Node.JS
sudo yum install -y gcc-c++ make
sudo curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
sudo yum install -y nodejs
#node -v
sudo npm install npm@latest -g
#npm -v
sudo curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install -y yarn
#yarn -v

# Java
sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
#java -version
#javac -version

# Add Python modules
curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"
sudo python /tmp/get-pip.py
sudo pip install PyYAML --upgrade --force-reinstall --ignore-installed awsebcli
sudo pip install awsebcli --upgrade --force-reinstall
sudo pip install boto3 --upgrade --ignore-installed awsebcli
sudo pip install docker-compose --upgrade
#sudo docker-compose version
sudo pip install pip --upgrade
sudo pip install pep8
#python --version

# Python 3
sudo yum install -y python3
sudo pip3 install awsebcli --upgrade
sudo pip3 install boto3 --upgrade
sudo pip3 install pep8
#python3 --version
