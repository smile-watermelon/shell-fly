# 2.9 排序，唯一，重复

```shell
sort file.txt file1.txt > sorted.txt
```
or
```shell
sort file.txt file1.txt -o sorted.txt
```

按照数字排序
```shell
sort -n sum.txt | tr -s '\n' | 
```
逆序
```shell
sort -r sum.txt
```
按照月份进行排序
```shell
sort -M month.txt
```
合并两个已排序的文件
```shell
sort -m sort1 sort2
```
查找已排序不重复的行
```shell
sort file1 file2 | uniq
```
检查文件是否排过序
$? 接收sort 返回码
```shell
sort -C filename
if [ $? -eq 0 ]; then
  echo sorted
else
  echo unsorted
fi
```
```shell
cat<<EOF>data.txt
1 mac 2000
2 winxp 4000
3 bsd 1000
4 linux 1000
EOF
```
```shell
sort -nrk 1 data.txt
```
按照第二列排序
```shell
sort -k 2 data.txt
```
通过截取位置进行排序
```shell
cat<<EOF>data.txt
1010hellothis
2189dadad
7624dadddvv
EOF
```
```shell
sort -nrk 1,4 data.txt
```
```shell
sort -z data.txt | xargs -0
```

-b 忽略文件中的前导空白行，-d 以字典顺序进行排序
```shell
sort -bd  data.txt
```

去重，统计
'-u' 统计文本出现的次数
```shell
sort data.txt | uniq -u 
```
找出文本中重复的行
```shell
sort data.txt | uniq -d 
```
-s 忽略前两个字段，-w 指定比较的最大字符数
```shell
sort data.txt | uniq -s 2 -w 2
```

0值字节终止符
```shell
uniq -z data.txt
```
```shell
uniq -z data.txt | xargs -0 rm
```
创建临时文件/tmp
```shell
filename=`mktemp`
echo $filename
```
创建临时目录
```shell
dirname=`mktemp -d`
echo $dirname
```
仅生成文件名
```shell
tmpfile=`mktemp -u`
echo $tmpfile
```
根据模版创建文件名
```shell
mktemp test.xxx
```