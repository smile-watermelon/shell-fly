
- -eq 等于
- -ne 不等于
- -gt 大于
- -ge 大于等于
- -lt 小于
- -le 小于等于
- -d 是不是目录
- -f 是不是文件
- -L 是不是符号连接
- -r 是否可读
- -w 是否可写
- -s 判断对象长度是否为0
- -n 字符串的长度大于0时为真
- -z 判断变量是否存在值，字符串长度为0时为真

$() ，() 是执行一个子shell，子shell的执行结果不会影响当前shell，$() 是将执行完子shell的结果替换到当前为止
```shell
bindir="$(
  dirname "../bin";
  pwd
)"
echo $bindir
```


# if 方括号条件为true 执行then 后的语句
# if...
```shell
if [ -f "$1" ]; then
  ehco "file $1 exists"
fi
```


# if... else...
```shell
if [ $1 != $2 ]; then
  echo "$1 not equal $2"
else
  ehco "$1 equal $2"
fi
```

# if...elseif...else
```shell
if [ $1 == $2 ]; then
  echo "$1 equals $2"
elif [ $1 == $3 ]; then
  echo "$1 equals $3"
else
  echo "nothing"
fi
```
- [ $var -ne 0 -a $var -gt 2 ] -a 表示逻辑与
- [ $var -ne 0 -o $var -gt 2 ] -a 表示逻辑或

文件系统相关

[ -f $file ] 给定路径或文件名是不是文件，
[ -x $var ] 是否是可执行文件
[ -d $var ] 是否是目录
[ -e $var ] 文件存不存在
[ -c $var ] 是不是一个字符设备文件的路径
[ -b $var ] 是不是一个块设备文件的路径
[ -w $var ] 是否写
[ -r $var ] 是否可读
[ -L $var ] 是否是一个软连接

```shell
path="/etc/passwd"
if [ -e $pasth ]; then
    echo "路径存在"
else
    echo "路径不存在"
fi
```

字符串比较，最好使用双括号
[[ $str1 = $str2 ]] 两个文本一模一样
或
[[ $str1 == $str2 ]] 两个文本一模一样

[[ $str1 != $str2 ]] 
[[ -z $str1 ]] 是否包含空字符
[[ -n $str1 ]] 是否包含非空字符

test 对方括号的简写
```shell
if test $var -eq 0 ; then echo "true"; fi 
```

