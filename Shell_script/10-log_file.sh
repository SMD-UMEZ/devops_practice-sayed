#!/bin/bash

user=$(id -u)
All_logs=/home/ec2-user/shell-logs/
log_files="$All_logs/$0.log"  ## /home/ec2-user/shell-logs/filename.log##
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
dnf list installed nginx &>> $log_files
 valid nginx $?
 dnf install nginx -y &>> $log_files
valid1 nginx $?

dnf list installed mysql &>> $log_files
 valid mysql $?
 dnf install mysql -y &>> $log_files
valid1 mysql $?

dnf list installed python3 &>> $log_files
 valid python $?
 dnf install python3 gcc python3-devel -y &>> $log_files
valid1 python $?


