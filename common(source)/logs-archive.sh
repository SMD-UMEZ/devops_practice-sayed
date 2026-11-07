#!/bin/bash

source_dir=$1
destination_dir=$2
days=${3:-14}
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

if [ -z $source_dir ] || [ -z $destination_dir ];then
  echo "[ERROR]: Missing parameters"
  echo "USAGE: $0 <source_dir> <Destination_dir> (days[optional])"
  exit 1
fi
if [ ! -d $source_dir ]; then
 echo "The source_dir: $source_dir is not exists"
 exit 1
fi
if [ ! -d $destination_dir ]; then
 echo "the destination_dir:$destination_dir is not exists"
 exit 1
fi
echo "scanning for the log files older than 14 days"
files=$(find $source_dir -name "*.log" -type f -mtime +"$days")

if [ -z "$files" ]; then
   echo "there is no log file exists older than 14 days"
   exit 0
fi   

# while IFS= read -r FILE
# do
#   echo "$FILE"
# done <<< "$files"

archive="$destination_dir/log-archive-$TIMESTAMP.tar.gz"

echo "archiving log files into $destination_dir"
  sudo tar -czvf $archive $files

if [ $? -eq 0 ]; then
    echo "archival is success,deleting the log files"
  while IFS= read -r FILE
  do
    sudo rm -f $FILE
    echo "$FILE deleted successfully"

  done <<< "$files"
fi       
