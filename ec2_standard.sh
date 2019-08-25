#!/bin/bash

# Start out fully patched
sudo yum upgrade -y

# Install standard tooling
sudo yum install -y htop
sudo yum install -y jq

# Add AWS EFS capability
# Full EFS walk-through REF: https://docs.aws.amazon.com/efs/latest/ug/wt1-getting-started.html
# Just the mount commands REF: https://docs.aws.amazon.com/efs/latest/ug/wt1-test.html#wt1-mount-fs-and-test
sudo yum install -y amazon-efs-utils
sudo yum install -y nfs-utils

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

# Add Python modules
curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"
sudo python /tmp/get-pip.py
sudo pip install boto3 --upgrade
sudo pip install awsebcli --upgrade
