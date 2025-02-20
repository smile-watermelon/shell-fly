# 1.3 玩转变量

# bash 中每个变量的值都是字符串

# 查看系统重所有的环境变量
```shell
env
```

# 查看进程环境变量
```shell
cat /proc/$PID/environ
```

# 查看进程id
```shell
pgrep redis
```

# 查看redis 的环境变量
```shell
cat /proc/87352/envrion
```

# 文本替换
```shell
cat /proc/87352/envrion | tr '\0' '\n'
```

# 1.3.2 实战演练
# 输出变量
```shell
name=guagua
echo $name
echo ${name}
```

# 在echo 中使用变量
```shell
echo "my name is ${name}"

```

# 环境变量是在当前进程中未定义，从父进程继承而来的
# 导出环境变量
```shell
export PATH="$PATH:/home/guagua/code"
```

# 一些众所周知的环境变量：HOME，PWD，USER，UID，SHELL，

## 1.3.3 补充内容
# 获取变量的长度
```shell
length=${#name}
echo "name length is ${length}"
```

# 识别当前所使用的shell
```shell
echo $SHELL
```
或者
```shell
echo $0
```
# 检查是否为超级用户
```shell
if [ $UID -ne 0 ]; then
    echo not root user;
else
    echo root user
fi
```

## 1.4 使用函数添加环境变量
```shell
prepend() {
  [ -d "$2" ] && eval $1=\"$2':'\$$1\" && export $1;
}
```

# prepend PATH /opt/myapp/bin
# prepend 如果第二个参数为空，会在末尾加上冒号，改进如下
```shell
prepend() {
  [ -d $2 ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1;
}
```

# ${parameter:+expression} 如果parameter不为空，则使用expression的值
## 1.5 使用shell 进行数学运算

# 算数运算可以使用let 、(())、[] ，[] 被弃用，使用(())代替
```shell
no1=1
no2=2

let sum=no1+no2
sum1=$[ no1 + no2 ]
sum2=$[ $no2 + 3 ]
sum3=$(( no1 + 2 ))
```

# shellcheck disable=SC2006
```shell
sum4=`expr 3+4`
sum5=$(expr $no1 + 4)

echo $sum
echo $sum1
echo $sum2
echo $sum3
echo $sum4
echo $sum5
```


# 自加
let no1++
# 自减
let no1--

# 简写
let no1+=6

# bc 高级运算
```shell
echo "4 * 0.56" | bc

```

# 2.24
```shell
no=54
result=`echo "$no * 1.5" | bc`
echo $result
```

# 81.0
# scale=2,保留两位小数
```shell
echo "scale=2;3/8" | bc

```

# 进制转换
```shell
no=100
echo "obase=2;$no" | bc
#1100100
no=1100100
echo "obase=10;ibase=2;$no" | bc
```