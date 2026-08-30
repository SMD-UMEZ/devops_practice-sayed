#!/bin/bash

AMI="ami-0220d79f3f480ecf5"
ZONE_ID="Z0556960G0CHQIF223HF"
DOMAIN_ID="mylab.sbs"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

###VALIDATION########

if [ $# -lt 2 ];then
 echo -e "$R [ERROR]:: Atleast 2 arguments required $N"
 echo "USAGE: $0 [Create/Delete] [Instance 1] [Instance 2...] "
 exit 1
fi 