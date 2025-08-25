#!/bin/bash

Source=/tmp/app-logs

if [ -d $Source ] 
then 
echo " the directory exists " 
else 
echo " please check the weather the $Source path is present or not" 
exit 1
fi

