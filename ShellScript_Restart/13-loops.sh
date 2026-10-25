#!/bin/bash

user_id=$(id -u)
LOGS_DIR=/var/log/shell.log/
LOG_FILE="$LOGS_DIR/$0.log"

if [ $user_id -ne 0 ];then
echo "please run the script with root user"
exit 1
else

VALIDATE() {
    if [ $2 -ne 0 ];then
    echo "Installation of $1 is failure..."
    else
    echo "Installation of $1 is success...."
    fi
}

for package in $@ 
do 

dnf list installed $package
if [ $? -ne 0 ];then
echo "installing $package ........."
dnf install $package -y
VALIDATE $package $?
else 
echo "$package is already installed... skipping"
fi
fi
done