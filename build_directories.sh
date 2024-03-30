#!/bin/bash

# find path to desktop and store
DESKTOP_PATH=$HOME/Desktop
echo "The absolute path to the Desktop directory is: $DESKTOP_PATH"

# LOG directory to be created on the Desktop (for logs files associated with each captured packets)
LOG_DIR_NAME="LOGS"
LOG_DIR_FULL_PATH="$DESKTOP_PATH/$LOG_DIR_NAME"
echo "The absolute path to the LOGS directory will be: $LOG_DIR_FULL_PATH"

# PCAP directory to be created on the Desktop (for packet capture)
PCAP_DIR_NAME="PCAPS"
PCAP_DIR_FULL_PATH="$DESKTOP_PATH/$PCAP_DIR_NAME"
echo "The absolute path to the PCAPS directory will be: $PCAP_DIR_FULL_PATH"

# Options:
# concatenate with the PCAP directory we want to build
# concatenate with the log or txt directory we want to build
# Or don't concatenate and directly use mkdir -p "${DESKTOP}/PCAPS" "${DESKTOP}/LOGS"

# Buiding directories
mkdir -p $LOG_DIR_FULL_PATH $PCAP_DIR_FULL_PATH # Not sudo 'cause problem at opening created files in the dirs that have been created
# The -p option tells mkdir to create the directory only if it does not exist, and it won’t modify or affect the existing directory
