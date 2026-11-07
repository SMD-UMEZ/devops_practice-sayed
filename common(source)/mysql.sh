#!/bin/bash

source ./common.sh
app_name=mysqld
root


dnf list installed mysqld &>> $LOG_FILE

if [ $? -eq 0 ]; then
 echo -e " $TIMESTAMP {INFO} $Y  mysql is already installed....SKIPPING $N " | tee -a $LOG_FILE
 else
 echo "Installing mysql......"
dnf install mysql-server -y  &>> $LOG_FILE
 Valid $? "Installing mysql"
fi
 enable_restart

 mysql_secure_installation --set-root-pass RoboShop@1
 Valid $? "root password set-up"
 


 