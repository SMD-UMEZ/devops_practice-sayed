#!/bin/bash

USER=$( id -u)

if [ $USER -ne 0 ]; then 
echo "please login as root user"
exit 1
fi

dnf install pythddon -y
status=$($?)
echo " installing python......"
if [ $status -ne 0 ]; then
echo " python installation failed"
exit 1
else
echo " python installation success"
fi