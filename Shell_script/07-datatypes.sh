#!/bin/bash

NUM1=$1
NUM2=$2

SUM=$(($NUM1+$NUM2))

echo "total count:$SUM"

### array #####
MOVIES=("RRR" "SPIDER" "AVENGERS")
echo "all movie names: ${MOVIES[@]}"
echo "third movie name: ${MOVIES[2]}"





Names=("Sayed""Mahammad""Umez")
echo "My name is ${Names[@]}"