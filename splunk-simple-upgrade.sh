#!/usr/bin/env bash

# This is a simple upgrade script for Splunk on Linux x64.
#
# It will download the latest Splunk version, generate a diag then proceed to the upgrade while writing the output to the console as well as in a log file.
#
# More info on github : https://github.com/d2si-spk/aws-ec2-user-data-splunk-quick-lab-install-no-popup

# Set the script to exit when a command fails
set -o errexit

# Set the script to produce a failure return code if any command errors between pipelines 
set -o pipefail

# Set the script to exit when it tries to use undeclared variables
set -o nounset

# Set $timestamp variable for logging
timestamp=$(date '+%a, %d %b %Y %H:%M:%S %z')

# Download the latest Splunk version
wget --output-document splunk-latest-linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=latest&product=splunk&filename=.tgz&wget=true' 2>&1 | tee "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 1/8 - Downloaded latest Splunk build"

# Generate a Splunk diag
splunk diag --collect=etc 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 2/8 - Generated a Splunk diag"

# Check Splunk version
splunk version 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 3/8 - Checked Splunk version"

# Stop Splunk
splunk stop 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 4/8 - Stopped Splunk"

# Unpack Splunk tgz file to /opt
tar --extract --gzip --file splunk-latest-linux-x86_64.tgz --directory /opt 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 5/8 - Extracted Splunk to /opt"

# Start Splunk and accept upgrade
splunk start --accept-license --answer-yes 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 6/8 - Started Splunk and accepted upgrade"

# Check Splunk version
splunk version 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 7/8 - Checked Splunk version"

# Check Splunk status
splunk status 2>&1 | tee --append "$(dirname "$0")"/"$(basename "$0")".log

echo "${timestamp} - 8/8 - Checked Splunk status"
