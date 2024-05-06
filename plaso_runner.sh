#!/bin/bash

# Command to run log2timeline.py

# Check if log2timeline.py is installed
if ! command -v log2timeline.py &> /dev/null; then
    echo "[!] log2timeline.py is not installed. Installing..."

    # Install plaso-tools
    sudo add-apt-repository universe -y
    sudo add-apt-repository ppa:gift/stable -y 
    sudo apt-get update 
    sudo apt-get install plaso-tools -y
    echo "[+] log2timeline.py installed successfully."
else
    echo "[+] log2timeline.py is installed on this system."
fi

echo "[+] running log2timeline now..."
log2timeline.py --storage-file timeline.plaso /path/to/artifacts

# Check if log2timeline.py was successful
if [ $? -eq 0 ]; then
    # If successful, run psort.py
    psort.py  -o L2tcsv timeline.plaso --slice "date > '2024-01-10T00:00:00' "  -w hostname-plasp-timeline.csv 
else
    echo "[!] log2timeline.py failed. Exiting."
    exit 1
fi
