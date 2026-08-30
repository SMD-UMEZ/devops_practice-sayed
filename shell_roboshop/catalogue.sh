#!bin/bash

LOG_FOLDER="/var/log/roboshops"
sudo mkdir -p $LOG_FOLDER
sudo chown -R ec2-user:ec2-user $LOG_FOLDER
sudo chmod -R 755 $LOG_FOLDER
LOG_FILE="$LOG_FOLDER/$0.log"

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ];then
echo "please run this script as root usr" | tee -a $LOG_FILE
exit 1
fi

VALIDATION(){
 if [ $1 -ne 0 ];then
 echo -e "$TIMESTAMP $2....is $R failure $N" | tee -a $LOG_FILE
 else
 echo -e "$TIMESTAMP $2....is $G success $N" | tee -a $LOG_FILE
 fi
}

dnf module disable nodejs -y &>> $LOG_FILE
VALIDATION $? "disabling the previous version"
dnf install nodejs -y &>> $LOG_FILE
VALIDATION $? "enabiling the latest version"
dnf install nodejs -y &>> $LOG_FILE
VALIDATION $? "Installing Nodejs"
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
VALIDATION $? "Creating roboshop system user"

mkdir -p /app
VALIDATION $? "Creating app directory"