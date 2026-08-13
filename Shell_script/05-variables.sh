#!/in/bash

#TIME_STAMP=$(date)

#echo " Time is :$TIME_STAMP"

START_TIME=$(date +%s)

sleep 5

END_TIME=$(date +%s)

total_time=$(($END_TIME-$START_TIME))

echo " total time to execute this cmd:$total_time"