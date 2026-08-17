#!/bin/bash

username=$(id -u)

if [ $username -eq 0 ]; then
echo "Installing mongodb............"
else
echo "login as root user to proceed..."
fi