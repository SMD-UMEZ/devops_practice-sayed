#!/bin/bash

user=$( id -u)

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
    echo"unsuccessfull"
    exit 1
    fi

}

for package in $@
do
dnf list installed $package
 if [ $? -eq 0 ];then 
 echo "$1 is alredy insateel.........skipping"
 else
  echo "installing $1"
 dnf install $package -y
 valid $package $?
 fi
done