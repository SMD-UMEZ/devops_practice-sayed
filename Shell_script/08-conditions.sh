#!/bin/bash
Number=$1
#gt - greater than
#lt - less than
#eq - equal
#ne - not equal
#le - less than or equal
#ge - greater than or equal
if [ $Number -gt 20 ]; then
echo " given Number is greater than 20"
elif [ $Number -eq 20 ]
echo " given Number is equal to 20"
else [ $Number -lt 20 ]
echo " Given number is less than 20 "
