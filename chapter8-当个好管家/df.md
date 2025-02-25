## 8.2 监视磁盘使用情况

- df disk free 
- du disk usage

查看某个文件占用磁盘空间
```shell
du file.txt
```
查看目录所有文件占用空间
- -a 递归
- -h 以KB，MB，GB单位显示
- -c 输出默认加上一行总计
- -s summarize 合计，只输出总计结果
- -b 以字节为单位打印输出
- -k 以KB 为单位打印输出
- -m 以M 为单位打印输出
- -B 打印以指定块为单位的文件大小

```shell
du -a dir 
```
```shell
du -h file
```
```shell
du -h dir
```
排除部分文件
```shell
du --exclude "WILDCARD" dir
```
```shell
du --exclude "*.txt" files
```
从文件中获取需要排除的列表
```shell
du --exclude-from EXCLUDE.txt dir
```
根据深度统计
```shell
du --max-depth 2 dir
```

找出指定目录中最大的10个文件
包含目录
```shell
du -ak dir | sort -nrk 1 | head -n 11
```
改进
```shell
find . -type f -exec du -k {} \; | sort -nrk 1 } head
```

```shell
df -h
```

## 8.3 计算命令执行时间
默认使用的是shell的time , 命令选项有限
系统time，/usr/bin/time
- -a 追加方式添加
- -o 输出到文件
- -f 格式化打印 
- %e real 时间
- %U user 时间
- %S sys 时间
- %C 运行时的命令名称及命令行参数
- %D 进程非共享数据区域的大小，以KB为单位
- %E 进程使用的real时间
- %x 进程退出的状态
- %k 进程接收到的信号数量
- %W 进程被交换出主存的次数
- %Z 系统页面大小
- %P 进程所获得的CPU 的百分比，（user+sys）/总运行时间
- %K 进程的平均总（data + stack + text ) 内存使用量，以KB 为单位
- %w 进程主动进程上下文切换的次数，例如IO操作
- %c 进程被迫进行上下文切换的次数，时间片到期

```shell
time command
```
将信息输出到文件
```shell
/usr/bin/time -o output.txt command
```
```shell
/usr/bin/time -f "format str" command
```
```shell
/usr/bin/time -f "Time %U" -a -o time.log uname
```
对表准输出，和信息输出进行重定向
```shell
/usr/bin/time -f "Time %U" uname > command.txt 2> time.log
```

## 8.4 收集与当前登录用户，启动日志，及启动故障的相关信息

获取当前登录用户信息
- TTY (teleTYperWriter) 与文本终端相关联的设备文件，当用户生成一个新的终端时，对应的设备文件会在
/dev/pts/3 ，可以通过输入tty 获得当前终端的设备路径
```shell
who
```
更详细信息
```shell
w
```
```
 14:49:30 up 6 days, 18:15,  2 users,  load average: 0.19, 0.22, 0.18
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
root     pts/0    10.211.55.2      Fri12    0.00s  1.49s  0.00s w
root     pts/1    10.211.55.2      Fri17    1:25   0.04s  0.04s -bash
```
列出当前登录主机的用户列表
```shell
users
```

```shell
users | tr ' ' '\n' | sort | uniq
```
查看系统已经加电运行了多长时间
```shell
uptime
```
```shell
uptime | grep -Po '\d{2}\:\d{2}\:\d{2}'
```
获取上次启动及登录用户的会话信息
```shell
last
```
查看单个用户信息
```shell
last user
```
失败的用户登录信息
```shell
lastb
```

## 8.5 列出1小时内占用CPU 最高的10个进程
```shell
secs=3600
unit_time=60

steps=$(( $secs / $unit_time ))

echo watching cpu usage...


for (( i = 0; i < steps; i++ )); do
    ps -eo comm,pcpu | tail -n +2 >> /tmp/cpu_usage.$$
    sleep $unit_time
done

echo
echo cpu eaters

cat /tmp/cpu_usage.$$ | \
awk '
{ process[$1]+=$2; }
END{
  for i in process ; do
      printf("%-20s %s\n", i, process[i]);
  done
}
' | sort -nrk 2 | head
```
## 8.6 使用watch 监视命令输出
- -d 差异的地方用不同的颜色显示
- -n 输出时间间隔
  默认2秒更新一次

```shell
watch command
```
or 
```shell
watch 'commands'
```
```shell
watch 'ls -l | grep "^d"'
```
指定输出时间间隔 
```shell
watch -n 5 'ls -l'
```

## 8.7 记录文件及目录访问
```shell
inotifywait -m -r -e create,move,delete,$path -q
```

## 用logrotate 管理日志文件

- missingok 如果日志文件丢失，则忽略，然后返回
- notifempty 仅当源文件非空时才对其进程轮替
- 限制轮替日志文件的大小 也可以使用1MB
- compress 允许使用gzip 压缩数据
- weekly 指定进行轮替的时间间隔，daily,weekly,monthly,yearly
- rotate 5 需要保留旧日志的归档数量
- create 指定创建文件的模式

需要安装该服务，配置文件在/etc/logrotate.d

编写特定程序的日志配置

例如：/var/log/program.log

```shell
cat /etc/logrotate.d/program
{
  missingok
  notifempty
  size 30k
    compress
  weekly
    rotate 5
  create  0600 root root  
}
```

## 8.10 通过监视用户登录找出入侵者
```shell
# intruder_detech.sh
AUTHLOG=/var/log/auth.log
if [[ -n $1 ]]; then
    AUTHLOG=$1
    echo using log file : $AUTHLOG
fi
LOG=/tmp/valid.$$.log
grep -v "invalid" $AUTHLOG > $LOG

users=$(grep "Failed password" $LOG | awk '{ print $(NF-5) }' | sort | uniq)

printf "%-5s|%-10s|%-10s|%-13s|%-33s|%s\n" "Sr#" "User" "Attempts" "IP address" "Host_mapping" "Time range"

ucount=0
ip_list="$(egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")" $LOG | sort | uniq

for ip in $ip_list ; do
    grep $ip $LOG > /tmp/temp.$$.log
    
    for user in $users;
do
    grep $user /tmp/temp.$$.log> /tmp/$$.log
    cut -c-16 /tmp/$$.log > $$.time
    tstart=$(head -1 $$.time)
    start=$(date -d "$tstart" "+%s")
    tend=$(tail -l $$.time)
    end=$(date -d "$tend" "+%s")
    
    limit=$(( $end - $start ))
    if [ $limit -gt 120]; then
        let ucount++
        
        IP=$(egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" /tmp/$$.log | head -1)
        time_range="$tstart-->$tend"
        attempts=$(cat /tmp/$$.log|wc -l)
        host=$(host $IP | awk '{print $NF}')

        printf "%-5s|%-10s|%-10s|%-13s|%-33s|%s\n" "$ucount" "$user" "$attempts" "$IP" "$host" "$time_range"

    fi
done

done

rm/tmp/valid.$$.log /tmp/$$.log $$.time /tmp/temp.$$.log 2> /dev/null
```

## 8.11 监视远程磁盘的健康情况
```shell
# disklog.sh

logfile="diskusage.log"

if [ -n $1 ]; then
  logfile=$1
fi

if [ ! -e "$logfile" ]; then
    printf "%-8s %-14s %-9s %-8s %-6s %-6s %-6s %s\n" "date" "ip address" "device" "capacity" "used" "free" "percent" "status" > $logfile
fi

IP_LIST="127.0.0.1 0.0.0.0"

(
for ip in $IP_LIST ; do
    ssh guagua@$ip 'df -H' | grep ^/dev/ > /tmp/$$.df
    
    while read line;
    do
      cur_date=$(date +%D)
      printf "%-8s %-14s " $cur_date $ip
      echo $line | awk '{ printf("%-9s %-8s %-6s %-6s %-8s", $1, $2,$3,$4,$5) }'
      pusg=$(echo $line | egrep -o "[0-9]+%")
      # 变量替换
      pusg=${pusg/\%/};
      if [ $pusg -lt 80]; then
        echo safe
      else
        echo alert
      fi 
    done< /tmp/$$.df
done
) >> $logfile
```