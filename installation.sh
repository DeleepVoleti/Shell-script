#!/bin/bash

uid=$(id -u)

if [ $uid -ne 0 ]
then 
    echo " please get root acess to run this code "
fi

dnf install mysql -y

echo " hi dilip" 