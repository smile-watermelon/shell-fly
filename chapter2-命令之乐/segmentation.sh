#!/bin/bash

split -b 1k data-split.txt -d -a 4

read -p "Enter number: " no;
read -p "Enter name: " name
echo $no $name