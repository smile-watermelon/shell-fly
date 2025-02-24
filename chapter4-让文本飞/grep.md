## 4.3 grep 搜索文本

```shell
cat<<EOF> a.txt
hello 
shell
guagua
EOF
```
```shell
cat<<EOF> b.txt
hello 
shell
EOF
```

```shell
grep guagua a.txt --color=auto
```

```shell
grep -E '[a-z]+' a.txt
```

```shell
egrep '^g' a.txt --color=auto
```
打印除了匹配到的行
```shell
grep -v '^g' a.txt
```
统计匹配到的行数
```shell
grep -c guagua a.txt
```
匹配出现的次数，-o 匹配到的数据单独成一行
```shell
echo -e "1 2 3 4\nhello\n5 6" | egrep -o "[0-9]" | wc -l
```
打印包含匹配的行号
```shell
grep guagua -n a.txt
```
打印匹配的偏移字节
```shell
echo gun is not unix | grep -bo "not"
```
搜索多个文件找出匹配的文件
```shell
grep -l guagua a.txt b.txt
```
递归搜索
```shell
grep guagua . -rn
```
指定多个匹配模式
```shell
grep -e "pattern1" -e "pattern2"
```

```shell
echo this is a line of text | grep -e "line" -e "text" -o
```
排除某些文件
```shell
grep guagua . -rn --exclude "*.sh"
```
打印匹配结果之后的n行
```shell
seq 10 | grep 5 -A 3
```
打印匹配结果之前的n行
```shell
seq 10 | grep 5 -B 3
```
打印前后各n行
```shell
seq 10 | grep 5 -C 3
```

## 4.4 cut 按列切分文件

显示第二列，第3列
cut -f 1,2 filename
```shell
cat<<EOF>cut.txt
no name sex age
1 guagua 男 18
2 didi 女 30
EOF
```

打印除了某列之外的其他列
```shell
cut -f 1,2 -d " " --complement cut.txt
```
打印区间字符
```shell
cut -c1-4 cut.txt
```
提取多个字段
```shell
cut -c1-2,8-10 --output-delimiter "," cut.txt
```

