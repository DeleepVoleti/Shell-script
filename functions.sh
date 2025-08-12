#!/bin/bash 
 

 ValidateUser(){
if [ $1 -ne 0 ]
then echo "run this code with root access"
exit 1 
fi
 }

validate() {
if [$1 -ne 0]
then echo "installation is failure"
else echo "success or already installed"

}





 ValidateUser $( id -u )
 

dnf install mysql -y 
 validate $? 