#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
echo "please login with root access to run this script"
exit 1
fi

dnf install nginx -y

if [ $? -ne 0 ]; then 
echo " installation failed"
exit 1
else 
echo " installation success"
fi