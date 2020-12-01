#!/bin/bash

#Set Bash instructions
#For more information look here http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu

#Set environment variable which points to the main ClamAV virus definition file
MAIN_FILE="/var/lib/clamav/main.cvd"

#Start freshclam to download the latest virus definitions
if [ ! -f ${MAIN_FILE} ]; then
    /usr/bin/freshclam
fi

#Run freshclam as a daemon and check 6 times per day for new virus definitions
/usr/bin/freshclam -d -c 6

#Run the ClamAV Deamon and specify the config file
exec /usr/sbin/clamd -c /etc/clamav/clamd.conf