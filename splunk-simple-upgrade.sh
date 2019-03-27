#!/usr/bin/env bash

# This is a simple upgrade script for Splunk on Linux x64.
#
# It will download the latest Splunk version, generate a diag then proceed to the upgrade while writing the output to the console as well as in a log file.
#
# More info on github : https://github.com/d2si-spk/splunk-simple-upgrade-latest-version

# Set the script to exit when a command fails
set -o errexit

# Set the script to produce a failure return code if any command errors between pipelines 
set -o pipefail

# Set the script to exit when it tries to use undeclared variables
set -o nounset

# Set $timestamp variable for logging
timestamp=$(date '+%m-%d-%Y %H:%M:%S.%3N %z')

# Set $log_file variable for logging
log_file=$(dirname "$0")/$(basename "$0")
log_file="${log_file%.*}.log"

# Download the latest Splunk version
wget --output-document splunk-latest-linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=latest&product=splunk&filename=.tgz&wget=true' 2>&1 | tee "${log_file}"

echo "${timestamp} - 1/9 - Downloaded latest Splunk build" | tee --append "${log_file}"

# Generate a Splunk diag
splunk diag --collect=etc 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 2/9 - Generated a Splunk diag" | tee --append "${log_file}"

# Check Splunk version
splunk version 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 3/9 - Checked Splunk version" | tee --append "${log_file}"

# Stop Splunk
splunk stop 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 4/9 - Stopped Splunk" | tee --append "${log_file}"

# Unpack Splunk tgz file to /opt
tar --extract --gzip --file splunk-latest-linux-x86_64.tgz --directory /opt 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 5/9 - Extracted Splunk to /opt" | tee --append "${log_file}"

# Start Splunk and accept upgrade
splunk start --accept-license --answer-yes 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 6/9 - Started Splunk and accepted upgrade" | tee --append "${log_file}"

# Check Splunk version
splunk version 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 7/9 - Checked Splunk version" | tee --append "${log_file}"

# Check Splunk status
splunk status 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 8/9 - Checked Splunk status" | tee --append "${log_file}"

# Delete Splunk tgz file
rm --recursive --force splunk-latest-linux-x86_64.tgz 2>&1 | tee --append "${log_file}"

echo "${timestamp} - 9/9 - Removed Splunk installation source" | tee --append "${log_file}"
