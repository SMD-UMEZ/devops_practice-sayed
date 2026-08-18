#!/bin/bash

user=$( id -u)
LOG=/home/ec2-user/shell-logs
LOG_FILE=$LOG/$0.log
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
if [ $user -eq 0 ];then 
echo "proceeding with root"
else 
echo "login with root"
exit 1
fi

valid(){
    if [ $2 -eq 0 ]; then
    echo -e "$TIMESTAMP installing $1 programm is $G successfull $N"
    else 
    echo -e "$R unsuccessfull $N"
    exit 1
    fi

}

for package in $@
do
dnf list installed $package &>> LOG_FILE
 if [ $? -eq 0 ];then 
 echo -e "$TIMESTAMP $1 is alredy insateel.........$Y skipping $N "
 else
  echo "$TIMESTAMP installing $1"
 dnf install $package -y &>> LOG_FILE
 valid $package $?
 fi
done