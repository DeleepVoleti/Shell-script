#!/bin/bash
name=$( echo $0 | cut -d "." -f1 )
time=$(date +"%H:%M:%S")
logfile=/tmp/$time.$name.logfile


uid=$(id -u)
r='\e[31m'
g='\e[32m'
n='\e[0m'



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

dnf install mysql-server -y &>>$logfile
validate $? installing-my-sql 

systemctl enable mysqld &>>$logfile
validate $? enabling-my-sql

systemctl start mysqld &>>$logfile
validate $? starting-my-sql

mysql -u root -p"ExpenseApp@1" -e "SELECT 1;" &>>$logfile
 &>>$logfile
 if [ $? -ne 0 ]
 then echo -e " password is already set $r skipping this step....... $n "
 else 
 mysql_secure_installation --set-root-pass ExpenseApp@1
 validate $? password-setting
 fi

