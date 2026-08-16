#!/bin/bash

USER=$( id -u)

if [ $USER -ne 0 ]; then 
echo "please login as root user"
exit 1
fi

dnf install pythddon -y
status=$($?)

if [ $status -ne 0 ]; then
echo " python installation failed"
exit 1
else
echo " python installation success"
fi


USER=$( id -u)

if [  $USER -ne 0 ]; then
echo "please run this script with root access"
exit 1
fi

echo "installing my sql"
dnf install mysql -y

if [ $? -ne 0 ]; then 
echo "installing failure"
exit 1
else
echo "success"
fi