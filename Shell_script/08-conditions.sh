#!/bin/bash
NUMBER=$1
#gt - greater than
#lt - less than
#eq - equal
#ne - not equal
#le - less than or equal
#ge - greater than or equal
if [ $NUMBER -gt 20 ]; then
echo " given Number is greater than 20"
elif [ $NUMBER -eq 20 ]
  echo " given Number is equal to 20"
fi