#!bin/bash

userid=$(id -u)

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

dnf list installed mysql

if [ $? -ne 0 ]; then
echo "mysql is already installed.......SKIPPING"
else
dnf install mysql -y
VALIDATE mysql $?
fi
fi