#!/bin/bash

# Command Expample
## kill-port.sh 3000



PID=$(lsof -t -i:$1)

if [ -n "$PID" ]; then
    kill $PID
    echo "Killed PID $PID on port $1"
else
    echo "No process found on port $1"
fi
