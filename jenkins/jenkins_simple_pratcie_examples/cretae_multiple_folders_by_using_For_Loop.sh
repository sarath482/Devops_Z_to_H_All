#!/bin/bash
#Create Multiple Folders Using for Loop
#Author:sarath
#Date:######
#This will create folders named folder1 to folder10
for i in {1..10}
do
 mkdir "folder$i"
 echo "created folders$i"
done