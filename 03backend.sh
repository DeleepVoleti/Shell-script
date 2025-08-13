#!/bin/bash

name=$( echo $0 | cut -d "." -f1 )
time=$(date +"%H:%M:%S")
logfile=/tmp/$time.$name.logfile



RootCheck(){
if [ $uid -ne 0 ]
then 
echo " please run the code with root access"
exit 1 
fi 
}

RootCheck


echo " please enter the sql password" 
read Password


validate(){
if [ $1 -ne 0 ]
then 
echo -e " $2 is $r failure $n "
else 
echo -e " $2 is $g success $n"
fi
}

dnf module disable nodejs -y &>>$logfile
validate $? disabling-node-js

dnf module enable nodejs:20 -y &>>$logfile
validate $? enabling-node-js-20

dnf install nodejs -y &>>$logfile
validate $? installing-nodejs

id expense 
if [ $? -ne 0 ]
then 
useradd expense &>>$logfile
else
echo -e " expense user already exits , $r skipping $n "

mkdir -p /app &>>$logfile
validate $? /app-directory-creation

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$logfile
validate $? downloading-the-code

cd /app
rm -rf /app/* 
unzip /tmp/backend.zip &>>$logfile
validate $? unzipping-the-code &>>$logfile

cd /app

npm install &>>$logfile
validate $? installing-dependencies

cp /c/Repos/Shell-script/backend.service  /etc/systemd/system/backend.service

systemctl daemon-reload &>>$logfile
validate $? demon-reload 

systemctl start backend &>>$logfile
validate $? starting-backend

systemctl enable backend &>>$logfile
validate $? enabling-backend

dnf install mysql -y &>>$logfile
validate $? installing-mysql-client

mysql -h db.dilipswebsite.online -uroot -p$Password < /app/schema/backend.sql &>>$logfile
validate $? loading-schema-in-database

systemctl restart backend &>>$logfile
validate $? restart-backend