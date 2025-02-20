注意在mac 环境下，默认使用的shell，对一些格式支持不好

```shell
alias install='sudo apt-get install'
```

删除一个文件同时备份
```shell
alias rm='cp $@ ~/backup && rm $@'
```
## 1.10 设置日期和延时
```shell
date
```
Wed Feb 19 13:25:03 CST 2025
- 打印纪元时
```shell
date +%s
```
1739942742
将UTC 格式打印为时间戳格式
```shell
date --date "Wed Feb 19 13:25:03 CST 2025" +%s 
```
获取星期几
```shell
date --date "Feb 19 2025" +%A
```

```shell
date "+%d %B %Y"
```
格式化为 2025-02-19 13:45:05
```shell
date "+%Y-%m-%d %H:%M:%S"
```
检查一组命令所花的时间，%3N 表示获取当前时间的纳秒数，并窃取前三位获得毫秒数
```shell
start=$(date +%s%3N)

for i in ${seq 0 1000} ; do
    echo i=${i}
done

end=$(date +%s%3N)
diff=$((end - start))
echo ${diff}
```
使用tput sleep 从0开始计数
```shell
echo -n Count:
tput sc

count=0

while true; do
  if [ $count -lt 10 ]; then
      let count++
      sleep 1
      tput rc
      tput ed
      echo -n $count
  else
    exit 0          
  fi
    
done
echo -n
```
调试脚本： bash -x test.sh
- -x 在执行时显示参数和命令
- +x 禁止调试
- -v 当命令进行读取时显示输入
- +v 禁止打印输入

```shell
for i in {1..5} ; do
    set -x
    echo $i
    set +x
done
```
在bash 中 ：冒号表示shell 不要进行任何操作
```shell
function DEBUG() {
    [ "$_DEBUG" == "on" ] && $@ || :
}

for i in {1..5} ; do
    DEBUG echo $i
done
```
创建函数
```shell
function fname() {
  echo this is func 
}

fname
```
```shell
fnmae() {
  echo $1 $2
}
fname 1 2
```
- $@ 以列表的方式一次性打印所有参数
- $* 类似于$@，但是参数被作为单个实体

## fork 炸弹 这个递归函数可以调用自身，不断地生成新的线程，可以修改/etc/security/limits.conf 限制可以生成的最大进程数来避免
```shell
# :(){ :|:& };:
```
导出函数，导出后的函数作用域可以扩展到子进程
```shell
export -f fname

```
获取函数的返回值
```shell
cmd;

echo $? // $? 会给出命令cmd 的返回值
```
检测命令是否执行成功
```shell
CMD="command"
$CMD
if [ $? -eq 0 ]; then
    echo "命令执行成功"
else
  echo "命令执行失败"      
fi
```
向命令传递参数 N 是一个数字选项
- command -p -v -k N file
- command -pv -k N file
- command -cpk N file
- command file -pvk N

## 1.13 将命令序列的输出读入变量
```shell
ls | cat -n | tr -s " " > pip.txt
```
读取管道相连的命令序列输出
```shell
cmd=$(ls | cat -n | tr -s " ")
echo $cmd
```
或者使用反标记
```shell
cmd=`ls | cat -n | tr -s " "`
echo $cmd
```
() 圆括号定义一个子shell，所有的改变仅限于子shell，将子shell放入双引号可以保留输入的空格和换行
```shell
cat pip.txt

out=$(cat pip.txt)
echo $out

out="$(cat pip.txt)"
echo $out
```
## 不使用回车键来读取n个字符
- read -n number_of_chars var_name 读取n个字符并存入变量 var_name
```shell
read -n 2 var
echo $var
```
- 用无回显的方式读取密码
```shell
read -s var
echo $var
```
- 显示提示信息
```shell
read -p "Enter pwd:" pwd
echo $pwd
```
- 在限定时限内读取输入，timeout 是秒
```shell
read -t timeout var
```
- 用特定的定界符作为输入结束
```shell
read -d "!" var
echo $var
```

## 1.15 运行命令直至成功
运行$@ 的命令，知道成功后退出
```shell
repeat()
{
  while true
  do
    $@ && retutn    
  done  
}
```
改进，：冒号返回为0的退出码
```shell
repeat()
{
  while :; do
      $@ && return 
  done
}
```
```shell
repeat()
```
```shell
repeat()
{
  while :; do
    $@ && return ; sleep 10
      
  done
}
```

## 1.16.2 字段分割符和迭代器
IFS 默认的分隔符为空白字符（换行符，制表符，空格）
```shell
data="name,sex,rollno,location"
oldIFS=$IFS
IFS=, #now,
for item in $data ; do
    echo $item
done
IFS=$oldIFS
```
```shell
line="root:x:0:0:root:/root:/bin/bash"
oldIFS=$IFS
IFS=":"
count=0
for item in $line ; do
    [ $count -eq 0 ] && user=$item
    [ $count -eq 6 ] && shell=$item
    let count++
done
IFS=$oldIFS

echo $user\'s shell is $shell
```
ToDo 将有用户使用的shell 打印，
```shell
passwd=($(cat /etc/passwd))
#oldIFS=$IFS
#IFS=":"
count=0
for item in $passwd ; do
    echo $item
done

#IFS=$oldIFS
```
