#!/bin/bash

# TIME_STAMP=$(date)

# echo "Time is $TIME_STAMP"


Start_time=$(date +%S)

sleep 10

end_time=$(date +%S)

total_time=$(($end_time-$Start_time))

echo "total time taken to execute the cmd $total_time"