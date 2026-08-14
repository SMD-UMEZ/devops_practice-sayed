#!/bin/bash

USER=$( id -u)

if [  $USER -ne 0 ]; then
echo "please run this script with root access"
exit 1
fi