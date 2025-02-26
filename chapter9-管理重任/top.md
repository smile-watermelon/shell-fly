## 9.2 收集进程信息

ps 参数
- -f full 显示多列
- -e every 
- -ax all
- -o 指定要查看的列
- -u 指定用户的进程
- -U 指定真实用户的ID
- -L 查看进程相关的线程信息
- --sort 进程排序
  - -nlwp 按照线程的数量进程排序
  - NLP 是ps 输出中每个线程的id  

```shell
ps -f
```

```shell
ps -eo comm,pcpu | head
```

-o 支持的参数

- pcpu cpu 占用率
- pid 进程id
- ppid 父进程id
- pmem 内存使用率
- comm 可执行文件名
- cmd 简单命令
- user 启动进程的用户
- nice 优先级
- time 累计的CPU时间
- etime 进程启动后流逝的时间
- tty 所关联的tty 设备
- euid 有效的用户id
- stat 进程状态

ps 输出排序
```shell
ps [options] --sort --paramter1,+par2...
```

```shell
ps -eo comm,pcpu --sort -pcpu | head
```
查看相同命令对应的进程pid
```shell
ps -C java
```
```
    PID TTY          TIME CMD
 121720 ?        00:15:32 java
 165908 ?        15:30:34 java
```

```shell
ps -C java -o pid=
```
```
 121720
 165908
```

pgrep 获取特定命令的进程ID列表
```shell
pgrep java
```
输出结果如果不是换行符，自行指定输出结果定界符
```shell
pgrep command -d delimter_str
```
```shell
pgrep java -d ":"
```
```
121720:165908
```
返回命令的进程数量
```shell
pgrep -c java
```
根据指定用户查找进程
```shell
pgrep -u root,guagua java
```

```shell
ps -e u 
ps -e w # 表示宽松显示
```
显示进程的环境变量
```shell
ps -eo pid,cmd e | tail -n 3
```

确定文件内型
```shell
file filename
```
```shell
file /bin/ls
```
系统平均负载
```shell
uptime
```

## 9.3 杀死进程以及发送和响应信号

列出所有信号
```shell
kill -l
```
向进程发送指定的信号
```shell
kill -s signal pid
```
-s 参数
- SIGHUP 1 对控制进程或终端的终结进行挂起检测 （hangup detection)
- SIGINT 2 当按下Ctrl + C 时发送的信号
- SIGKILL 9 强行杀死进程
- SIGTERM 15 默认用于终止进程
- SIGTSTP 20 按下Ctrl + Z 时发送的信号

```shell
kill -s SIGKILL process_id
```
或
```shell
kill -9 pid
```
killall 通过命令名终止进程
```shell
killall process_name
```
```shell
kill -s SIGNAL process_name
```
```shell
killall -9 process_name
```
```shell
killall -u username process_name
```

```shell
pkill process_name
```
```shell
pkill -s SIGNAL process_name
```

捕获并响应信号
```shell
trap 'signal_handler_function_name' SIGNAL LIST
```
SIGNAL LIST 以空格分割，可以是信号编号或者信号名称
```shell
# sighandle.sh

function handler() {
  echo Hey,received signal: SIGINT
}

echo my process id is $$
trap 'handler' SIGINT

while true;
do
  sleep 1
done
```

## 9.4 向用户终端发送消息
```shell
cat message | wall
```
永许写入消息，默认是启用的
```shell
mesg n/y
```

给指定用户终端发送消息
```shell
# message_user.sh

username=$1

devices=`ls /dev/pts/* -l | awk '{ print $3,$10 }' | grep $username | awk '{print $2}'`

for dev in $devices;
do
  cat /dev/stdin > $dev
done  
```
```shell
./message_user.sh root < message.txt
```

## 9.5 采集信息
打印系统主机名

```shell
hostname
```
or 
```shell
uname -n
```
打印内核发行版本
```shell
uname -r
```
打印主机架构类型
```shell
uname -m 
```
打印cpu相关信息
```shell
cat /proc/cpuinfo
```
获取处理器名称
```shell
cat /proc/cpuinfo | sed -n 5p
```
打印系统可用内存总量
```shell
cat /proc/meminfo | head -1
```
or
```shell
fdisk -l
```
获取系统详细信息
```shell
lshw
```

## 9.6 使用proc 采集信息
/proc 是在内存中的伪文件系统（pseudo filesystem)
每个进程在/proc 都有一个对应的目录，目录名和进程id相同

查看进程相关的环境变量
```shell
cat /proc/1234/environ
```
cwd 是一个进到进程工作目录的符号链接

exe 是当前进程对应的可执行文件的符号链接

## 9.8 用bash读写MySQL数据库
```shell
# create_db.sh

user="user"
pass="pass"

mysql -u $user -p$pass <<EOF 2> /dev/null
create table student(
id int,
name varchar(100),
mark int,
dept varchar(4)
);
EOF

[ $? -eq 0 ] && echo create table student || echo table student already exists

mysql -u $user -p $pass student<<EOF
delete from student
EOF
```
写入数据
```shell
# wtite_data.sh
user="user"
pass="pass"
if [ $# -ne 1 ]; then
    echo $0 DATAFILE
    echo 
    exit 1
fi
data=$1

while read line;
do
  oldIFS=$IFS
  IFS=,
  values=($line)
  values[1]="\"`echo ${values[1]} | tr ' ' '#' `\""
  values[3]="\"`echo ${values[3]} `\""
  
  query=`echo ${values[@]} | tr ' #' ', '`
  IFS=$oldIFS
  
  mysql -u $user -p$pass student <<EOF
insert into student values($query)
EOF  
done < $data

echo wrote data info db
```

用户管理

添加用户
-m 创建家目录
```shell
useradd user -p password -m 
```
删除用户
--remove-all-files 参数删除和用户相关的所有文件
```shell
deluser username --remove-all-files
```
锁定和解锁用户
-L 锁定
-U 解锁
```shell
usermod -L username
```
设置密码账号的过期时间
```shell
chage -E date user
```
-m min_days 将更改密码的天数修改成 min_days
-M max_days 设置密码有效的最大天数
-W -WARN_DAYS 设置在密码到期前几天提醒修改密码

更改密码
```shell
passwd user
```
添加组
```shell
addgroup group
```
删除组
```shell
delgroup group
```
给组里添加用户
```shell
addgroup user group
```
