#!/bin/bash

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