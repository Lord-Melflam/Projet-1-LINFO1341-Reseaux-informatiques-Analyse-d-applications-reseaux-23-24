#!/bin/bash

if [ "$#" -ne  2 ]; then
    echo "Usage: $0 <pcap_file> <log_file_associated>"
    exit 1
fi

# Define the base paths
PCAP_DIR="$HOME/Desktop/PCAPS" # from build_directories.sh
LOGS_DIR="$HOME/Desktop/LOGS" # from build_directories.sh

# Opening Wireshark with a pcap file and its <associated!!!> log file from the terminal directly using the following command:
wireshark -r $PCAP_DIR/$1 -o tls.keylog_file:$LOGS_DIR/$2
