#!bin/bash

LOG_FOLDER="/var/log/roboshops"
sudo mkdir -p $LOG_FOLDER
sudo chown -R ec2-user:ec2-user $LOG_FOLDER
sudo chmod -R 755 $LOG_FOLDER
LOG_FILE="$LOG_FOLDER/$0.log"
SCRIPT_DIR=$PWD

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ $USERID -ne 0 ];then
echo "please run this script as root usr" | tee -a $LOG_FILE
exit 1
fi

VALIDATION(){
 if [ $1 -ne 0 ];then
 echo -e "$TIMESTAMP $2....is $R failure $N" | tee -a $LOG_FILE
 else
 echo -e "$TIMESTAMP $2....is $G success $N" | tee -a $LOG_FILE
 fi
}

dnf module disable nodejs -y &>> $LOG_FILE
VALIDATION $? "disabling the previous version"
dnf install nodejs -y &>> $LOG_FILE
VALIDATION $? "enabiling the latest version"
dnf install nodejs -y &>> $LOG_FILE
VALIDATION $? "Installing Nodejs"

id roboshop &>>$LOG_FILE
if [ $? -eq 0 ];then
   echo -e "Roboshop user already exists...... $Y SKIPPING $N"
   else
useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
VALIDATION $? "Creating roboshop system user"
fi
rm -rf /app
VALIDATION $? "Removing existing code"
rm -rf /tmp/catalogue.zip
VALIDATION $? "Removed Catalogue Zip"
mkdir -p /app
VALIDATION $? "Creating app directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>LOG_FILE
cd /app 
unzip /tmp/catalogue.zip &>>LOG_FILE
VALIDATION $? "Downloaded and extracted cat code"

npm install &>>LOG_FILE
VALIDATION $? "Installing Dependencies"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>>LOG_FILE
VALIDATION $? "Created systemctl service"

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>>LOG_FILE
VALIDATION $? "Adding mongo repo"
dnf install mongodb-mongosh -y &>>LOG_FILE
VALIDATION $? "Installing Mongodb_client"

INDEX=$(mongosh --host mongodb.mylab.sbs --eval 'db.getMongo().getDBNames().indexof("catalogue")') 

if [ $INDEX -lt 0 ];then
       mongosh --host mongodb.mylab.sbs </app/db/master-data.js &>>LOG_FILE
       VALIDATION $? "Load products"
else
       echo "Produts are already loaded ............$Y SKIPPPING $N"
fi
systemctl daemon-reload 
systemctl enable catalogue 
systemctl restart catalogue
VALIDATION $? "enabling and restart"