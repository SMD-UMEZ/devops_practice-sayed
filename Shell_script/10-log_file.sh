#!/bin/bash

user=$(id -u)
ALL=/home/ec2-user/shell-logs
LOG="$ALL/$0.log"  ## /home/ec2-user/shell-logs/filename.log##
if [ $user -ne 0 ]; then
echo "please login as Root user"
exit 1
fi

valid1(){
    if [ $2 -ne 0 ]; then
    echo "Installation is unsuccessfull"
    else
    echo "Installation successful"
    fi
}
dnf list installed nginx &>> $LOG
 if [ $? -eq 0 ];then
 echo "alredy insyalled"
 else
 dnf install nginx -y &>> $LOG
valid1 nginx $?
fi

dnf list installed mysql &>> $LOG
 if [ $? -eq 0 ];then
 echo "alredy insyalled"
 else
 dnf install mysql -y &>> $LOG
valid1 mysql $?
fi
dnf list installed python3 &>> $LOG
if [ $? -eq 0 ];then
 echo "alredy insyalled"
 else
 dnf install python3 gcc python3-devel -y &>> $LOG
valid1 python $?
fi

