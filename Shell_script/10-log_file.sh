#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ]; then
echo "please login as Root user"
exit 1
fi
valid(){
    if [ $2 -eq 0 ];then
echo "The ngnix programm is alredy installed.......Skipping"
else
echo "Installing the ngnix software" 
fi
}
valid1(){
    if [ $2 - ne 0]; then
    echo "Installation is unsuccessfull"
    else
    echo "Installation successful"
    fi
}
dnf list installed ngnix
 valid ngnix $?
 dnf install ngnix -y
valid1 ngnix $?

dnf list installed mysql
 valid mysql $?
 dnf install mysql -y
valid1 mysql $?

dnf list installed python
 valid python $?
 dnf install python -y
valid1 python $?


