## 7.2 网络设置

```shell
ifconfig eth0
```

## 7.9 使用ssh 进行端口转发

user 替换为本地主机的用户名
将本地的8000端口流量转发到远程的80端口
```shell
ssh -L 8000:www.kernel.org:80 user@localhost
```
将远程8000的端口流量转发到www.kernel.org 的80端口
- 将 REMOTE_MACHINE 替换为远程主机的的主机名或IP地址
- 将user 替换为使用ssh 进行访问的用户名
```shell
ssh -L 8000:www.kernel.org:80 user@REMOTE_MACHINE
```
### 非交互式端口转发
- -f 指定在执行命令前转入后台运行
- -L 指定远程主机的登录名
- -N 告诉ssh无需执行命令，只进行端口转发
```shell
ssh -fL 8000:www.kernel.org:80 user@localhost -N
```

### 反向端口转发
自己没介入网络，可以让别的用户访问自己
```shell
ssh -R 8000:localhost:80 user@REMOTE_MACHINE
```

## 在本地挂载点上挂载远程驱动器
意思是在本地可以访问远程主机的文件系统，来操作远程的文件像在本地操作一样
sshfs 允许将远程文件系统挂载到本地挂载点上
```shell
sshfs -o allow_other user@remoteAddr:/home/path /mnt/mountpoint
```

## 网络端口与流量分析
列出运行的端口
```shell
lsof -i
```
列出本地主机开发的端口
```shell
lsof -i | grep ":[0-9]\+->" -o | grep "[0-9]\+" -o | sort | uniq
```
```shell
netstat -tnp
```

## 创建套接字
```shell
nc -l 1234
```
连接套接字
```shell
nc HOST 1234
```
套接字快速文件复制
```shell
nc -l 1234 > destination_file
```
```shell
nc host 1234 < source_file
```

## 7.13 互联网连接共享
路由器挂了，使用本机插线接口联网，然后把自己当做路由器，和其他电脑共享网络

```shell
# netstaring.sh
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -A FORWARD -i $1 -o $2 -s 10.99.0.0/16 -m conntrack
--ctstate NEW -j ACCEPT
iptables -A FORWARD -m conntrack -ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A POSTROUTING -t nat -j MASQUERADE 
```
执行脚本
```shell
./netstaring.sh eth0 wlan0
```

## 使用iptables 架设简易防火墙
- -A 表明向链中添加一条新的规则，链就是一组规则的集合，这里使用的OUPUT链，对出站的流量进行控制
- -d 指定所要匹配分组目的地址
- -j 使iptables 丢弃（DROP) 符合条件的分组

阻塞发送到特定IP地址的流量
```shell
iptables -A OUTPUT -d 8.8.8.8 -j DROP
```

阻塞发送到特点端口的流量
```shell
iptables -A OUTPUT -p tcp -dport 21 -j DROP
```

清除对iptables 链所有的改动
```shell
iptables --flush
```