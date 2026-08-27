#!/bin/bash

LOGS_FOLDERS="/var/log/roboshop1"
sudo mkdir -p $LOGS_FOLDERS
sudo chown -R ec2-user:ec2-user $LOGS_FOLDERS
sudo chmod -R 755 $LOGS_FOLDERS
LOG_FILES="$LOGS_FOLDERS/$0.log"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ];then
echo "run this script with root access" | tee -a $LOG_FILES
exit 1
fi

VALID(){
    if [ $1 -ne 0 ];then
    echo -e "$TIMESTAMP  [ERROR] $2 is $R failed $N to install" | tee -a $LOG_FILES
    else
    echo -e "$TIMESTAMP [INFO] $2 is $G success $N " | tee -a $LOG_FILES
    fi
}

dnf module disable redis -y &>> $LOG_FILES
dnf module enable redis:7 -y &>> $LOG_FILES

dnf install redis -y &>> $LOG_FILES
VALID $? "Installing redis"

sed -i -e "s/127.0.0.1/0.0.0.0/g" -e "/protected-mode/ c protected-mode no" /etc/redis/redis.conf
VALID $? "Allowing remote connection redis"

systemctl enable redis 
systemctl start redis
VALID $? "Started redis"