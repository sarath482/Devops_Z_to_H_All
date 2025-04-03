#!/bin/bash
#Shell Script for Addition & Git Operations (Rebase, Merge, and Cherry-Pick)
#Author :Sarath
#Date:#########
#Version :V1
#############
# Simple script for add two numbers
echo "Enter first number "
read num1

echo "Enter second number"
read num2

sum=$((num1+num2))

echo "The Sum is: $sum"
# add substraction
echo "Enter first number"
read num3
echo "enter second number "
read num4
Sub=$((num3-num4))
echo "the Sub : $Sub"

echo "git branch delete command {git branch -d feature}"
echo "git rebase functionality"
echo "rebase to the master branch in to the feature branch command is git rebase feature"
echo "cherry-pic commits cheery-pic branch to master branch"