#!/bin/bash

USER=$( id -u)

if [ $USER -ne 0 ]; then 
echo "please login as root user"
exit 1
fi

dnf install pythddon -y

echo " installing python......"

if [ $? -ne 0 ]; then
echo " python installation failed"
else
echo " python installation success"
fi