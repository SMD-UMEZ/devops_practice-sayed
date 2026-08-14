#!/bin/bash
Number=$1
#gt - greater than
#lt - less than
#eq - equal
#ne - not equal
#le - less than or equal
#ge - greater than or equal
if [ $Number -ge 20]; then
echo "given number is greater then 20"
else
echo "given number is less then 20"
fi