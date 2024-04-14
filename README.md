[Nothing to be done at all - 26/03/24]
[Readme updated - 05/04/24]
[Readme Updated - 14/04/24]

**Title:** 
Network application analysis - Onedrive

**Description:** 
[Confidential]

**Link to the Project:** 
https://github.com/Lord-Melflam/Projet-1-LINFO1341-Reseaux-informatiques-Analyse-d-applications-reseaux-23-24

**Technologies Used:** 
  > **Wireshark** for packet captures (TCDUMP could also work but on relatively small scenarios)
  > **Bash scripts** created on purpose:
      **How they work**:
        . *create_scenarios.sh*: It's the main script, it launches the packets captures, and decrypts the final result with some specific args (see bash content)
        . *build_directory.sh*: It created the necessary directories for packets and associated .log files to be stored
        . *open_packets*: It opens packets with their corresponding .log files

**Requirements (for using scripts)**
  > Linux OS or its distributions (As essentially, these scripts won't work on Windows (Without some adaptation))
  > A laptop following the minimal requirement for using Wireshark: https://www.wireshark.org/docs/wsug_html_chunked/ChIntroPlatforms.html
  > **firefox** installed
  > Some specific user privileges (see SOLVE_USER_PRIVILEGES.md in the directory for common errors and how to solve them while running the scripts for the first time)

**Author/Contributors:** 
Autor: *francois.meli@student.uclouvain.be*
Contributor: *hendrix.juitcha@student.uclouvain.be*

**Errors/Missings**
  > Missing .pcap files capture (files too large): 6th and 7th scenario :
    Scenario6_WifiHome_SimpleFileDownload.pcap
    Scenario7_WifiHome_SimpleFileUpload.pcap 
  > See corresponding .log files in the LOGS/ directory)

**[Errors/Missing Solving]**: 
  > Added two equivalent .csv files (corresponding to the 2 missing .pcaps)
