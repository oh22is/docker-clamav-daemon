#!/bin/bash
# Set environment variable which points to the main ClamAV virus definition file
MAIN_FILE="/var/lib/clamav/main.cvd"

# Start freshclam to download the latest virus definitions
if [ ! -f ${MAIN_FILE} ]; then
    /usr/bin/freshclam
fi

# Start freshclam as a daemon
freshclam -d

# Start the ClamAV Deamon
clamd