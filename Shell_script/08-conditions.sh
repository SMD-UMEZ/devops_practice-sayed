#!/bin/bash
Number=$1
#gt - greater than
#lt - less than
#eq - equal
#ne - not equal
#le - less than or equal
#ge - greater than or equal
if [ $Number -gt 20 ];then
echo "given number is greater then 20"
elif [ $Number -eq 20 ]; then
echo "given no is equal to 20"
else
echo "given number is less then 20"
fi


if [ $Number -lt 20 ];then
Echo " give no is lessthan 20"
fi