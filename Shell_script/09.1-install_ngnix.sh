#!/bin/bash

username=$(id -u)

if [ $username -eq 0 ]; then
echo "Installing mongodb............"
else
echo "login as root user to proceed..."
exit 1
fi

dnf install mongodb -y

if [ $? -ne 0 ];then
echo "program is not installed"
exit 1
else
echo "program is installed to successfully"
fi