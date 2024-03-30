You can find out your username in a Linux system by opening a terminal and entering the command: 
**bash**
```
whoami
```

This command will display your current username. Alternatively, you can also use:
**bash**
```
echo $USER
```

This will also display your current username in the terminal. Remember to open a terminal window to run these commands.


The error message "Couldn't run dumpcap in child process: Permission denied" suggests that there is a permissions issue with the `dumpcap` utility, which Wireshark uses to capture packets. This can occur even if you are running Wireshark with `sudo` or as a root user. Here are steps to resolve the issue:

1. **Add your user to the `wireshark` group**: [Worked]
**bash**
```
sudo usermod -a -G wireshark your_username
```
Replace `your_username` with your actual username. This adds your user to the `wireshark` group, which should have the necessary permissions to capture packets.

2. **Log out and log back in**:
After adding your user to the `wireshark` group, you need to log out of your session and log back in for the changes to take effect. This refreshes your group memberships.

3. **Change the permissions of `dumpcap`**:
If the above steps don't work, you may need to change the permissions of the `dumpcap` executable to allow non-root users to capture packets:
**bash**
```
sudo chmod +x /usr/bin/dumpcap
```
This command makes `dumpcap` executable by all users, which can resolve the permission issue.

4. **Reconfigure Wireshark**: [Worked]
You can also reconfigure Wireshark to allow non-root users to capture packets:
**bash**
```
sudo dpkg-reconfigure wireshark-common
```
Choose "Yes" when prompted to allow non-superusers to capture packets.
Typically for that type of error:
"You do not have permission to capture on device "any".
(socket: Operation not permitted)"
   

**How do I change directory permissions in Linux?**

To change directory permissions in Linux, use the following:
**bash**
```
chmod +rwx filename # to add permissions
chmod -rwx directoryname # to remove permissions. 
chmod +x filename # to allow executable permissions.
chmod -wx filename # to take out write and executable permissions.
```

Note that “r” is for read, “w” is for write, and “x” is for execute. 

This only changes the permissions for the owner of the file.


**What are the three kinds of file permissions in Linux?**

There are three kinds of file permissions in Linux:

    Read (r): Allows a user or group to view a file.
    Write (w): Permits the user to write or modify a file or directory.
    Execute (x): A user or grup with execute permissions can execute a file or view a directory.  
More on site: https://www.pluralsight.com/blog/it-ops/linux-file-permissions

francois.meli@student.uclouvain.be
