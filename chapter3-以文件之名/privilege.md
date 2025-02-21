## 3.5 文件权限，所有位和粘滞位

```shell
chmod u=rwx g=rw o=r filename
```
其他用户添加执行权限
```shell
chmod o+x filename
```
删除权限
```shell
chmod o-x filename
```
```shell
chmod 764 filename
```
更改所有权
```shell
chown user:group filename
```
设置粘滞位
```shell
chmod a+t dir_name
```
递归设置权限
```shell
chmod -R 777 .
```
```shell
chown -R user:group .
```
设置文件不可修改
```shell
chattr +i file
```
移除不可修改操作
```shell
chattr -i file
```
创建符号链接
```shell
ln -s target symbolic_link_name
```
```shell
ln -s /var/www/ ~/web
```
打印符号文件
```shell
ls -l | grep '^l'
```
或者
```shell
find . -type l -print
```

## 3.9 列举文件类型统计信息
查看文件类型
```shell
file a.txt
```

- < <(...)：这是一种进程替换的语法，将 find 命令的输出作为 while 循环的标准输入
-   < <(find $path -type -f -print) 可以替换为
    <<< "`find $path -type -f -print`"
```shell
if [ $# -ne 1 ]; then
    echo "usage is $0 basepath"
    exit 
fi
path=$1

declare -A statarray

while read line;
do
  ftype=`file -b "$line" | cut -d, -f1` 
  let statarray["$ftype"]++
done  < <(find $path -type -f -print)

echo ============File types and counts==============

for ftype in "${!statarray[@]}";
do
  echo $ftype : ${statarray[$ftype]}
done  

```

## 3.12 查找文件差异并进行修补
```shell
cat<<EOF>version1.txt
this is the original text
line2
line3
line4
happy hacking !
EOF
```
```shell
cat<<EOF>version2.txt
this is the original text
line2
line4
happy hacking !
GNU is not UNIX
EOF
```
```shell
diff version1.txt version2.txt
```
一体化输出
```shell
diff -u version1.txt version2.txt
```
修补文件
```shell
diff -u version1.txt version2.txt > version.patch
```
将修补文件应用于version1.txt
```shell
patch -p1 version1.txt < version.patch
```
撤销修改
```shell
patch -p1 version1.txt < version.patch
```
目录差异
```shell
diff -Naur dir1 dir2
```
- -N 将所有缺失文件视为空文件
- -a 将所有文件视为文本违纪
- -u 生成一体化输出
- -r 遍历目录下的所有文件

## 3.13 
```shell
head -n 3 a.txt
```
```shell
tail -n 3 a.txt
```
打印前N行之外的行
```shell
tail -n +3 a.txt
```
```shell
PID=$(pidof FOO)
tail -f file --pid $PID
```

## 3.14 只列出目录的各种方法
```shell
ls -d */
```
```shell
ls -F | grep "/$"
```
```shell
ls -l | grep '^d'
```
```shell
find . -type d -maxdepth 1 -print
```

## 3.15 在命令行中使用pushd 和popd 的快速定位

```shell
pushd /Users/guagua/code/my/shell-fly/chapter2-命令之乐
pushd /Users/guagua/code/my/shell-fly/chapter1-小试牛刀
```
```shell
dirs
```
```shell
pushd +3
```

## 3.16 统计文件的行数，单词数，字符数
统计行
```shell
wc -l file
```
统计单词
```shell
wc -w file
```
统计字符
```shell
wc -c file
```
统计行，单词，字符
```shell
wc a.txt
```
打印最长的一行
```shell
wc -L a.txt
```