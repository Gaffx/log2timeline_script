#!/bin/bash

# Command to run log2timeline.py

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
