#!/bin/bash
source ./common.sh
app_name=mongod
root
mongorepo

 sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
 Valid $? "configuring the Host server"

 enable_restart

 print_total_time