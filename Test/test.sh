#!/bin/bash

# Exit on error
set -e

# Begin
echo 'Running Tests...'

# Run run-in-roblox
if output=$(run-in-roblox --place test.rbxl --script test/test.server.lua 2>&1); then
    echo 'Getting Results...'
    sleep 5 # Wait for run-in-roblox to finish
    echo "$output"
    if echo "$output" | grep -q '0 failed, 0 skipped'; then
        echo 'Tests passed successfully.'
        exit 0
    else
        echo 'Error: Tests did not pass.'
        exit 1
    fi
else
    # Catch errors
    echo "Error running 'run-in-roblox': $output"
    exit 1
fi