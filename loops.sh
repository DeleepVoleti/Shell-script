#!/bin/bash

 for i in {1..6}
 do 
 if [ $i -gt 3]
 then echo -e "\e[32m hii dilip" 
 else 
 echo -e " \e[31m  hii dilip"
 fi
 done
