#!/bin/bash

# 读取密码，不显示密码
# stty -echo 禁用echo
echo -e "enter password"
stty -echo
read password
stty echo
echo $password
echo Password read.