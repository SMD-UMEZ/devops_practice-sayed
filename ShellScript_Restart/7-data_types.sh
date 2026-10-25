#!bin/bash

NUM=199
NUM2=44

SUM1=$(($NUM-$NUM2))
SUM2=$(($NUM+$NUM2))

echo " $SUM1 "
echo " $SUM2 "


#Arrays

Movies=("RRR" "Bahubali" "Billa")

echo "movies are : ${Movies[@]}"
echo "first movie is : ${Movies[0]}"
echo "last movie is : ${Movies[2]}"