#!/bin/bash 
 

 ValidateUser(){
if [ $1 -ne 0 ]
then echo "run this code with root access"
exit 1 
fi
 }

 ValidateUser $( id -u )

dnf install mysql -y 
