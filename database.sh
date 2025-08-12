#!/bin/bash
name=$( echo $0 | awk -d "." -f1 )
logfile=/tmp/$name.logfile

uid=$(id -u)
r=\e[31m
g=\e[32m
n=\e[0m

if [ $uid -ne 0 ]
then 
echo " please run the code with root access"
exit 1 
fi 

validate(){
if [ $1 -ne 0 ]
then 
echo -e " $2 is $r failure $n "
else 
echo -e " $2 is $g success $n"
}

dnf install mysql-server -y &>>$logfile
validate $? installing my-sql 

systemctl enable mysqld &>>$logfile
validate $? enabling my-sql

systemctl start mysqld &>>$logfile
validate $? starting my-sql
