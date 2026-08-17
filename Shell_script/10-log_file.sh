#!/bin/bash

user=$(id -u)
ALL=/home/ec2-user/shell-logs
LOG="$ALL/$0.log"  ## /home/ec2-user/shell-logs/filename.log##
if [ $user -ne 0 ]; then
echo "please login as Root user"
exit 1
fi
valid(){
    if [ $2 -eq 0 ];then
echo "The $1 programm is alredy installed.......Skipping"
else
echo "Installing the $1 software" 
fi
}
valid1(){
    if [ $2 -ne 0 ]; then
    echo "Installation is unsuccessfull"
    else
    echo "Installation successful"
    fi
}
dnf list installed nginx &>> $LOG
 valid nginx $?
 dnf install nginx -y &>> $LOG
valid1 nginx $?

dnf list installed mysql &>> $LOG
 valid mysql $?
 dnf install mysql -y &>> $LOG
valid1 mysql $?

dnf list installed python3 &>> $LOG
 valid python $?
 dnf install python3 gcc python3-devel -y &>> $LOG
valid1 python $?


