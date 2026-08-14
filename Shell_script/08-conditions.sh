#!/bin/bash
NUMBER=$1
#gt - greater than
#lt - less than
#eq - equal
#ne - not equal
#le - less than or equal
#ge - greater than or equal

if [ $NUMBER -gt 20 ]; then
        echo " greater than 20"
elif [ $NUMBER -eq 20 ]
        echo "equal to 20"
