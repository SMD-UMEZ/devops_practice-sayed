#!/bin/bash

user=$( id -u)
LOG=/home/ec2-user/shell-logs
LOG_FILE=$LOG/$0.log
if [ $user -eq 0 ];then 
echo "proceeding with root"
else 
echo "login iwth root"
exit 1
fi

valid(){
    if [ $2 -eq 0 ]; then
    echo "installing $1 programm"
    else 
    echo "unsuccessfull"
    exit 1
    fi

}

for package in $@
do
dnf list installed $package &>> LOG_FILE
 if [ $? -eq 0 ];then 
 echo "$1 is alredy insateel.........skipping"
 else
  echo "installing $1"
 dnf install $package -y &>> LOG_FILE
 valid $package $?
 fi
done