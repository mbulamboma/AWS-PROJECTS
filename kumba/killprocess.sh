#!/bin/bash
PORT=3005

# Get the list of PIDs using the specified port
PIDS=$(sudo lsof -t -i :$PORT)

# Kill each process using the port
for PID in $PIDS; do
    sudo kill $PID
done
