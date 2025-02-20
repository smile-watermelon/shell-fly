#!/bin/bash

# 引用数组有问题
declare -A ass_array
ass_array=(["index1"]="val1" ["index2"]="val2")
# 没有输出
#echo "${ass_array[index1]}"

#ass_array["index1"]=v1
#ass_array["index2"]=v2

echo "${!ass_array[*]}"
# 获取数组所有的key
echo "${!ass_array[@]}"
echo "${ass_array[*]}"

# 获取数组的长度
echo "${#ass_array[*]}"