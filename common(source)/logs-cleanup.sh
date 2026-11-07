#!/bin/bash

source_dir=$1
days=${2:-14}

if [ -z $source_dir ]; then
  echo "[ERROR]: Missing parameters"
  echo "USAGE: $0 <source_dir> (days[optional])"
  exit 1
fi  
if [ ! -d $source_dir ]; then
 echo "the $source_dir is not exists"
 exit 1
fi

echo "Scanning $source_dir for delete the files older than 14days "
FILES=$(find $source_dir -name "*.log" -type f -mtime +$days)

if [ -z $FILES ];then
    echo "No log files older than 14 days"
    exit 0
fi

while IFS= read -r file
do
echo "file to be deleted : $file"
 rm -rf $file
 echo "$file deleted successfully"
done <<< "$FILES"
