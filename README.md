## Splunk upgrade script

This is a simple upgrade script for Splunk on Linux x64.

It will download the latest Splunk version, generate a diag then proceed to the upgrade while writing the output to the console as well as in a log file.

### Prerequisites

To use this script to upgrade a Splunk instance, please consider the prerequisites below.

#### Make sure the script match your environment/package

It is dedicated to Linux x64 tgz.

#### Make sure Splunk website can be reached from your Splunk instance

The package will be retrieved from splunk.com.

#### Use the script

Copy the script to the target system, make it executable and run it.

#### Logging

The output is logged in splunk-simple-upgrade-latest-version.log.

#### Splunk diag

A light Splunk diag is generated in /opt/splunk directory.
