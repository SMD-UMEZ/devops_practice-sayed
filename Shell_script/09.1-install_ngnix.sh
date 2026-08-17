#!/bin/bash

username=$(id -u)

if [ $username -eq 0 ]; then
echo "Installing nodejs............"
else
echo "login as root user to proceed..."
exit 1
fi

dnf install nodejs -y

if [ $? -ne 0 ];then
echo "program is not installed"
exit 1
else
echo "program is installed  successfully"
fi

### Functions    #########

Valid(){
    if [ $2 -ne 0 ]; then
    echo "programm is not installed"
    exit 1
    else
    echo "program is installed"
    fi
}

dnf install python3 gcc python3-devel -y
Valid python $?

dnf install golang -y
Valid golang $?

dnf install jaaaav -y
Valid java $?