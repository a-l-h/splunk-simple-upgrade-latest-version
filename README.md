# ![](logo3.svg) Splunk upgrade script

This is a simple upgrade script for Splunk on Linux x64.

It will download the latest Splunk version, generate a diag then proceed to the upgrade while writing the output to the console as well as in a log file.

## Prerequisites

To use this script to upgrade a Splunk instance, please consider the prerequisites below.

### Make sure the script match your environment/package

It is dedicated to Linux x64 tgz.

### Make sure wget is installed

Wget is used to download Splunk latest version.

### Make sure path to `${SPLUNK_HOME}/bin` has been added to your bash profile

As the script uses splunk commands, path to `${PSLUNK_HOME}/bin` must be added.

One can either use :

```shell
  {
    echo "export PS1='\[\033[1;32m\]\$(whoami)@\$(hostname): \[\033[0;37m\]\$(pwd)\$ \[\033[0m\]'"
    echo "export SPLUNK_HOME=\"/opt/splunk\""
    echo "export PATH=\${SPLUNK_HOME}/bin:\${PATH}"
    echo ". \${SPLUNK_HOME}/share/splunk/cli-command-completion.sh"
  } >> /etc/bashrc
```

or refer to: https://docs.splunk.com/Documentation/CoE/ssf/Handbook/UnixProfile#Add_Splunk_to_PATH

### Make sure Splunk website can be reached from your Splunk instance

The package will be retrieved from splunk.com.

### Use the script

Copy the script to the target system, make it executable and run it.

### Logging

The output is logged in `splunk-simple-upgrade.sh.log`.

### Splunk diag

A light Splunk diag is generated in `/opt/splunk` directory.
