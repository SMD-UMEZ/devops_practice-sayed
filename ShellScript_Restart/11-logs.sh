#!bin/bash

userid=$(id -u)
LOGS_DIR=/home/ec2-user/shell_logs
LOG_FILE="$LOGS_DIR/$0.log"

if [ $userid -ne 0 ]; then

echo "please login and run with root access"
exit 1
else


VALIDATE() {
    if [ $2 -ne 0 ]; then
    echo "$1 is failed to install"
 else
 echo "$1 is successfully installed"
fi
}

dnf list installed mysql &>> $LOG_FILE

if [ $? -eq 0 ]; then
echo "mysql is already installed.......SKIPPING"
else
echo "installing........."
dnf install mysql -y &>> $LOG_FILE
VALIDATE mysql $?
fi
fi