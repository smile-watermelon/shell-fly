# 2.11 分割文件和数据

```shell

str="hello shell"
exec 3> data-split.txt
for i in {1..10000} ; do
    echo "hello shell" $i >&3
done

exec 3>&-

```
按照指定的文件大小进行切割
```shell
split -b 1k data-split.txt
```
指定切割后文件的后缀为数字
```shell
split -b 1k data-split.txt -d -a 4
```
指定切割后文件名前缀
```shell
split -b 1k data-split.txt -d -a 4 split-file
```
按行分割
```shell
split -l 1000 data-split.txt -d -a 4 split-file
```

csplit 进行分割，csplit 是 split 的变体，可以按照指定的字符进行分割，直到
找到下一个这个字符
```shell
cat<<EOF > server.log
SERVER-1
[connection] 192.168.0.1 success
[connection] 192.168.0.1 success1
[connection] 192.168.0.1 success2
SERVER-2
[connection] 192.168.0.2 success2
[connection] 192.168.0.2 success2
[connection] 192.168.0.2 success2
SERVER-3
[connection] 192.168.0.3 success2
[connection] 192.168.0.3 success2
[connection] 192.168.0.3 success2
EOF
```

```shell
csplit server.log /SERVER/ -n 2 -s {*} -f server -b "%02d.log"; rm server00.log
```
- /SERVER/ 用来匹配某一行，分割即从此行开始
- /REGEX/ 用来匹配某一行，直到包含SERVER结束
- -n 指定分割后文件名后缀的数字个数，01，02
- -s 静默分割
- -f 指定分割后文件名前缀
- -b 指定后缀格式
- {*} 表示重复执行分割，直到文件末尾

## 2.12 根据扩展名切分文件名

提取文件名，shell 中变量命名最好使用下划线
```shell
file_jpg="sample.jpg.jpeg"
name=${file_jpg%.*}
echo $name
```
提取文件扩展名
```shell
file_jpg="sample.jpg.jpeg"
extension=${file_jpg##*.}
echo $extension
```
- ${var%.*} 删除%右侧的通配符，% 属于非贪婪匹配，匹配是从右向左，%% 是贪婪匹配
- .* 是匹配所有，这个有点像以点. 作为定界符
- '#' 是从左向右匹配，## 是贪婪匹配

## 2.13 批量重命名和移动
```shell
for (( i = 0; i < 3; i++ )); do
  if [ $i -eq 2 ]; then
    echo $i > $i.jpg  
  else 
    echo $i > $i.png
  fi
done
```
```shell
count=1
for img in `find . -iname '*.png' -o -iname '*.jpg' -type f -maxdepth 1`
do
   new=image-$count.${img##*.}
   echo "renaming $img to $new"
   mv $img $new
   let count++
done
```
其他重命名的方法
```shell
rename *.JPG *.jpg
```
将空格替换为下划线
```shell
rename 's/ /_/g' * 
```
转换文件名的大小写
```shell
rename 'y/A-Z/a-z/' * 
```

```shell
echo "mp3" > audio.mp3
```
-exec 参数需要在末尾加 \;
```shell
find . -type f -name '[0-9].mp3' -exec mv {} ./mp3/ \;
```

## 2.14 拼写检查与词典操作
grep ^标记单词的开始，$标记单词的结束
-q 禁止产生任何输出
```shell
grep "^$1$"  /usr/share/dict/README -q
```
列出文件中以特定单词开头的所有单词
```shell
look f1 file.txt
```
look 命令已默认词典文件作为参数
```shell
look f1
```

查找所有的f1
```shell
grep f1 file.txt
```

## 2.15 交互输入自动化
```shell
read -p "Enter number: " no;
read -p "Enter name: " name
echo $no $name
```
```shell
echo -e "1\nhello\n" | ./segmentation.sh
```
expect
```shell
spawn ./interactive.sh
expect "Enter number: "
send "\n"
expect "Enter name: "
send "hello \n"
expect eof
```
- spawn 指定自动化哪一个命令

利用多核处理
- $! 获取进程的pid
```shell
PIDARRAY=()
for file in file.txt file1.txt ; do
    md5sum $file &
    PIDARRAY+=("$!")
done
wait ${PIDARRAY[@]}
```