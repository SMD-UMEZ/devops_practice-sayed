#!/bin/bash

source ./common.sh
app_name=redis
root

dnf list installed redis &>> $LOG_FILE

redis

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
Valid $? "Configuring the redis"

enable_restart
print_total_time


 