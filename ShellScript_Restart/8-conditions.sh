#!bin/bash

NUMBER=$1

if [ $NUMBER -gt 20 ]; then

echo "given number ($NUMBER) is greater than 20"

elif [ $NUMBER -eq 20 ]; then
echo "given number ($NUMBER) is equal than 20"


else
 echo "given no.($NUMBER) is less than 20"

 fi