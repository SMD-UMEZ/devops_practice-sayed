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

ACTION=$1
shift ##first arg will be removed

if [ $ACTION != "create" ] && [ $ACTION -ne "delete" ]; then
    echo -e "$R [ERROR]:: First arg must be either create or delete $N"
    echo "USAGE: $0 [Create/Delete] [Instance 1] [Instance 2...] "
 exit 1
fi

get_instance_id(){
    name=$1
    aws ec2 describe-instances \
  --filters \
    "Name=tag:Name,Values=roboshop-$name" \
    "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].InstanceID" --output text
}

for instance in $@
do
         INSTANCE_ID=$(get_instance_id $instance)
    if [ $ACTION == "create" ];then
        if [ $INSTANCE_ID == "None" ];then
             echo "Launching instances:: Roboshop-$instance"
              INSTANCE_ID=$(aws ec2 run-instances \
                --image-id $AMI \
                --instance-type t3.micro \
                --security-groups roboshop-common roboshop-$instance \
                --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='roboshop-$instance'}]' \
                --query 'Instances[0].InstanceId' \
                --output text)
             echo "Instances Launched: $INSTANCE_ID"
            else
             echo "roboshop-$instance is already running: $INSTANCE_ID"
        fi

        if [ $instance == "frontend" ]; then
                    IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID \
                    --query 'Reservations[*].Instances[*].PublicIpAddress' \
                    --output text)
                    R53=$DOMAIN_ID
        else
                    IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID \
                    --query 'Reservations[*].Instances[*].PrivateIpAddress' \
                    --output text)
                    R53=$instance.$DOMAIN_ID
        fi

                            ### Updating R53_record
                            aws route53 change-resource-record-sets \
                            --hosted-zone-id $ZONE_ID \
                            --change-batch '{
                                "Changes":[{
                                "Action":"UPSERT",
                                "ResourceRecordSet":{
                                    "Name":"'$R53'",
                                    "Type":"A",
                                    "TTL":1,
                                    "ResourceRecords":[{"Value":"'$IP'"}]
                                }
                                }]
                            }'
               echo "R53 record updated : $instance"
                            
        else
        if [ $INSTANCE_ID == "None" ];then
            echo " $instance is already destroyed nothing to do.... "
         else
             aws ec2 terminate-instances --instance-ids $INSTANCE_ID
             echo "Terminating Instance:: $instance"
        fi                     

    fi
     
done