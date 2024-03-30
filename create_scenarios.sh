#!/bin/bash

# Check if the correct number of arguments was provided
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <scenario_type> <network_interface> <web_address> <flag[\"true\" for displaying a decrypted result(recommended)]>"
    exit 1
fi

# Retrieve the arguments
SCENARIO=$1
INTERFACE=$2
WEB=$3
BOOL=$4

# Create the directories if they do not exist (parallel script)
./build_directories.sh

# Define the base paths
PCAP_DIR="$HOME/Desktop/PCAPS" # from build_directories.sh
LOGS_DIR="$HOME/Desktop/LOGS" # from build_directories.sh

chmod 700 $PCAP_DIR $LOGS_DIR
: <<'END_COMMENT'
For a regular file, chmod 700 ensures the following:
The owner can read, write, and execute the file.
The group and others have no access to the file.
END_COMMENT

# Create the output file names
OUTPUT_FILE="${PCAP_DIR}/${SCENARIO}.pcap"
LOG_OUTPUT_FILE="${LOGS_DIR}/${SCENARIO}.log"

#################
# Start file existance checking

# List of file names to check
file_absolute_names=("$OUTPUT_FILE" "$LOG_OUTPUT_FILE")

# Initialize a variable to keep track of existing files
existing_files=()

# Check if each file exists in the directory
for file_name in "${file_absolute_names[@]}"; do
    if [ -f "$file_name" ]; then # file already exists
        existing_files+=("$file_name")
    fi
done

# Print the result
if [ ${#existing_files[@]} -eq 0 ]; then
    echo "New file creation ongoing ..."
else
    echo "The following file(s) already exist(s): ${existing_files[*]}."
    read -p "Continue ? (y/n): " answer
    # Define your list of values (space-separated)
    my_list="y Y Yes YEs YES YeS yes yEs yES yeS" # 2**3 + 2 possibilities 

    # String to check
    my_item="${answer}"

    # Check if the item is in the list
    if [[ $my_list =~ (^|[[:space:]])$my_item($|[[:space:]]) ]]; then
        echo "The item '$my_item' is in the list."
    else
        echo "Try again with different filename <scenario>"
        exit 1 # equivalent to 'no' (Do not continue)
    fi
    
fi
# End file existance checker
#################

# Create the log file
touch "${LOG_OUTPUT_FILE}"

# Set the SSLKEYLOGFILE environment variable and launch Firefox
export SSLKEYLOGFILE="${LOG_OUTPUT_FILE}" 
echo "SSLKEYLOGFILE is set to: $SSLKEYLOGFILE" # Confirm that the variable is set correctly otherwise Firefox might have not yet written the keys to the log file by the time Wireshark tries to use them

sleep 1 # Waiting time for previous task [To strengthen the previous step]

firefox "${WEB}" & # The 3rd last step could feet in 1 (As seen in TP), but here's a more detailled way

# Get the process ID of Firefox
#FIREFOX_PID=$!

# Launch Wireshark with the specified interface and associated log file
wireshark -i "${INTERFACE}" -k -w "${OUTPUT_FILE}" -o tls.keylog_file:${LOG_OUTPUT_FILE} & # I don't believe "-o tls.keylog_file" is useful there (Cause of the GUI limitations/restrictions of wireshark)

# Get the process ID of wireshark
#WIRESHARK_PID=$!

# replacement for wireshark -i "${INTERFACE}" -k -w "${OUTPUT_FILE}" &
: <<'END_COMMENT'
-o tls.keylog_file:${LOG_OUTPUT_FILE}
This option sets the path to the keylog file that Wireshark will use to decrypt TLS traffic.
equivalent to configuring Analysis Tool: In Wireshark, go to Edit -> Preferences -> Protocols -> TLS and specify the path to your keylog file.
END_COMMENT

# Wait for the user to press any key to stop Wireshark and close the browser
read -p "Press any key (from this terminal) to stop Wireshark and close the browser" -n 1 -s

: <<'END_COMMENT'
# Close Wireshark
kill $WIRESHARK_PID

# Close Firefox
kill $FIREFOX_PID # or good practice kill "${...}"
END_COMMENT

# Close Wireshark more gracefully using its PID
pkill -SIGTERM -f wireshark
#pkill -SIGTERM -P $WIRESHARK_PID # [Unwanted behavior]
#kill $WIRESHARK_PID [Abrupt and may cause errors]

# Give Wireshark a moment to close properly
sleep 2

# Close Firefox more gracefully
pkill -SIGTERM -f firefox 
#pkill -SIGTERM -P $FIREFOX_PID # [Unwanted behavior]
#kill $FIREFOX_PID [same as before]

# Give Firefox a moment to shut down cleanly
sleep 2

# Display a confirmation message
echo "Wireshark and Firefox have been closed. Files saved to $PCAP_DIR and $LOGS_DIR."

# Displaying (or no) the result to work in (To avoid the wireshark GUI graphical interface) 
if [ "$BOOL" == "true" ]; then
    ./open_packets.sh "${SCENARIO}.pcap" "${SCENARIO}.log"
fi
echo "true : Decrypted result displayed in wireshark."
echo "otherwise : use ./open_packets.sh .pcap_relative_file_name_(in PCAPS) .log_filename_associated"
