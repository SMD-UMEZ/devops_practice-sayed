#!/bin/bash

user_id=$(id -u)
LOGS_DIR=/var/log/shell.log/
LOG_FILE="$LOGS_DIR/$0.log"

if [ $user_id -ne 0 ];then
echo "please run the script with root user"
exit 1
fi

VALIDATE() {
    if [ $2 -ne 0 ];then
    echo "Installation of $1 is failure..." | tee -a $LOG_FILE
    else
    echo "Installation of $1 is success...." | tee -a $LOG_FILE
    fi
}

for package in $@ 
do 

dnf list installed $package | tee -a $LOG_FILE
if [ $? -ne 0 ];then
echo "installing $package ........."
dnf install $package -y &>> $LOG_FILE
VALIDATE $package $?
else 
echo "$package is already installed... skipping" | tee -a $LOG_FILE
fi

done