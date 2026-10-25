#!/bin/bash

user_id=$(id -u)
LOGS_DIR=/var/log/shell.log/
LOG_FILE="$LOGS_DIR/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R='\e[31m'
G='\e[32m'
Y='\e[33m'
N='\e[0m'

if [ $user_id -ne 0 ];then
echo "please run the script with root user"
exit 1
fi

VALIDATE() {
    if [ $2 -ne 0 ];then
    echo -e "$TIMESTAMP [ERROR] Installation of $1 is $R failure $N..." | tee -a $LOG_FILE
    else
    echo -e " $TIMESTAMP {INFO} Installation of $1 is $G success$N...." | tee -a $LOG_FILE
    fi
}

for package in $@ 
do 

dnf list installed $package &>> $LOG_FILE
if [ $? -ne 0 ]; then
echo "installing $package ........."
dnf install $package -y &>> $LOG_FILE
VALIDATE $package $?
else 
echo -e " $TIMESTAMP {INFO} $package is already installed... $Y skipping $N" | tee -a $LOG_FILE
fi

done