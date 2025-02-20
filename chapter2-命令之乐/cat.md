## 2.2 cat 拼接


- cat file1 file2 ...

"-" 被作为stdin 文本的文件名
```shell
echo "text through stdin" | cat - file.txt
```
压紧文件中相邻的的空白行 
```shell
cat -s file.txt
```
-T 显示制表符，^I
```shell
cat -T file.txt
```
显示行号
```shell
cat -n file.txt
```
### 2.3 录制回放终端会话
格式如下
- timing.log 存储时序信息，描述每个命令在何时运行，output文件存储命令
- -t 将时序数据导入到stderr 
```shell
script -t 2> timing.log -a output.session
type commands;

exit 
```
播放
```shell
scriptreplay timing.log output.session
```

## 2.4 文件查找及文件列表
打印文件及目录
```shell
find . -print
```
查找匹配的文件名
```shell
find ../../shell-fly -name "*.sh"
```
忽略大小写
```shell
find ../../shell-fly -iname "*.sh"
```
匹配多个条件中的一个，使用 or
```shell
find . \( -name "*.txt" -o -name "*.sh" \) 
```
匹配文件路径
```shell
find ../../shell-fly -path "*chapter2*"
```
使用正则表达式
```shell
find . -regex ".*\(\.sh\|\.md\)$"
```
查找不匹配的文件，否定
```shell
find  . ! -regex ".*\(\.md\|\.sh\)$"
```
根据文件类型查找
- type 
```shell
find ../ -type d 
```
文件类型
- f 普通文件
- d 目录
- c 字符设备
- b 块设备
- l 符号链接
- s 套接字
- p FIFO

linux 中文件的三种时间
- atime 文件最近一次被访问的时间
- mtime 文件最后一次修改的时间
- ctime 文件权限被最近修改的文件

打印出最近7天被访问过的文件
"-" 表示小于，+ 大于
```shell
find . -type f -atime -7 
```
- amin 访问时间，分钟
- mmin 修改时间
- cmin 元数据修改

基于文件大小的搜索
```shell
find . -type f -size +2k
```
删除找到的文件
```shell
find . -type f -name "*.log" -delete
```
通过权限查找
```shell
find . -type f -perm 644 
```
根据用户查找
```shell
find . -type f -user guagua 
```
exec参数执行命令
{} 相当于是一个占位符，匹配的文件会把花括号替换掉，
```shell
find . -type f -user root -exec sudo chown guagua {} \;
```
```shell
find . -type f -name "*.txt" -exec printf "Text file is: %s\n" {} \;
```
跳过某些目录
```shell
find ../ \( -type f \) -o \( -name ".idea" -prune \) -o \( -name ".git" -prune \)  
```