#!/bin/bash

disk_usage=$( df -hT | grep -v Filesystem )
usage_threshold=5

while IFS= read -r line
do
    usage=$( echo "$line" | awk '{print $6}' | cut -d "%" -f1 )
    parameters=$( echo "$line" | awk '{print $7}' )
    if [ "$usage" -ge "$usage_threshold" ]; then
        Message+="High consuming disk space in $parameters : $usage \n "
    fi

done <<< "$disk_usage"

echo -e "$Message"