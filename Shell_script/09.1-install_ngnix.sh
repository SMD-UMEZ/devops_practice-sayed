#!/bin/bash

USER=$( id -u)

if [ $USER -ne 0 ]; then 
echo "please login as root user"
exit 1
fi