#!/bin/bash

name=$( echo $0 | cut -d "." -f1 )
time=$(date +"%H:%M:%S")
logfile=/tmp/$time.$name.logfile
uid=$(id -u)

RootCheck(){
if [ $uid -ne 0 ]
then 
echo " please run the code with root access"
exit 1 
fi 
}

RootCheck

validate(){
if [ $1 -ne 0 ]
then 
echo -e " $2 is $r failure $n "
else 
echo -e " $2 is $g success $n"
fi
}

dnf install nginx -y &>>$logfile
validate $? installing-nginx

systemctl enable nginx &>>$logfile
validate $? enabling-nginx

systemctl start nginx &>>$logfile
validate $? starting-nginx

rm -rf /usr/share/nginx/html/*

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$logfile
validate $? copying-frontend-code

cd /usr/share/nginx/html

unzip /tmp/frontend.zip &>>$logfile
validate $? unzipping-the-code

cp /c/Repos/Shell-script/expense.conf /etc/nginx/default.d/expense.conf
validate $? nginx-reverse-proxy-configuration

systemctl restart nginx &>>$logfile
validate $? restarting-nginx
