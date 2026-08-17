#!/bin/bash

username=$(id -u)

if [ $username -eq 0 ]; then
echo "Installing mongodb............"
else
echo "login as root user to proceed..."
fi

dnf install gogfgdb -y

if [ $? -ne 0 ];then
echo "program is not installed"
else
echo "program is installed to successfully"
fi