#!/bin/bash

###### special var ##########

echo "All variables passed to script: $@"
echo "Number of variables passed : $#"
echo "First variable: $1"
echo " Script name : $0"
echo " who is running the script : $USER "
echo "hi"
echo " $PWD "
echo " current script process ID: $$"
sleep 5 &
echo " bg pid: $!"
echo "line no: $LINENO"
echo " executed in seconds: $seconds "
