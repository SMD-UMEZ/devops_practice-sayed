#!/bin/bash

AMI="ami-0220d79f3f480ecf5"
ZONE_ID="Z0556960G0CHQIF223HF"
DOMAIN_ID="mylab.sbs"

for instance in $@
do 
INSTANCE_ID=$(
    aws ec2 run-instances \
  --image-id $AMI \
  --instance-type t3.micro \
  --security-groups roboshop-common roboshop-$instance \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='roboshop-$instance'}]' \
  --query 'Instances[0].InstanceId' \
  --output text
)
echo "INSTANCE ID IS: $INSTANCE_ID"

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

done