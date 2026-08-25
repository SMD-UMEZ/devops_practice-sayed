#!/bin/bash

LOGS_FOLDERS="/var/log/roboshop1"
sudo mkdir -p $LOGS_FOLDERS
sudo chown -R ec2-user:ec2-user $LOGS_FOLDERS
sudo chmod -R 755 $LOGS_FOLDERS
LOG_FILES="$LOGS_FOLDERS/$0.log"

USERID=$(ID -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ];then
echo "run this script with root access" | tee -a $LOGS_FOLDERS
exit 1
fi

VALID(){
    if [ $1 -ne 0 ];then
    echo -e "$TIMESTAMP  [ERROR] $2 is $R failed $N to install" | tee -a $LOGS_FOLDERS
    else
    echo -e "$TIMESTAMP [INFO] $2 is $G success $N " | tee -a $LOGS_FOLDERS
    fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALID $? Mongodb

dnf install mongodb-org -y &>> $LOG_FILE
VALIDATION $? "Installing Mongodb"

dnf enable --now mongod
VALIDATION $? "satring and enabling mongodb" 

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf
VALIDATION $? "Allowing remote connection mongodb"

systemctl restart mongod
VALIDATION $? "Restarting mongod"