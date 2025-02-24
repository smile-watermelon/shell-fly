## 4.6 使用awk 进行高级文本处理

可以对列和行进行处理，有很多内建功能例如数组和函数

基本结构
```shell
awk 'BEGIN{ print "start" } pattern { commands } END { print "end" }' file
```
- awk 'BEGIN{ statement } { statement } END { statement }' file 
- awk "BEGIN{ statement } { statement } END { statement }" file

```shell
awk 'BEGIN{ i=0 } { i++ } END { print i }' filename
```
1. 执行流程，先执行 BEGIN 代码块的语句，主要做初始化操作，定义变量，打印表头等
2. pattern 对读取到的每行信息进行处理。
3. END 是读取完文件所有行之后执行，例如打印分析结果，汇总信息。

print 的参数是以逗号进行分割时，参数打印以空格作为定界符，在awk 中 print 打印双引号是当做拼接操作符
```shell
echo -e "line1\nline2" | awk 'BEGIN{ print "start" } {print} END{ print "end"}' 
```
例如，echo 往标准输出写入一行，awk 执行一次
v1 v2 v3
```shell
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1,var2,var3}'
```
v1-v2-v3
```shell
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1 "-" var2 "-" var3}'
```

### 特殊变量
- NR 表示记录数量，对应行号
- CF 字段数量，对应当前行的字段数
- $0 当前行的文本内容
- $1 第一个字段的文本内容
- $2 第二个字段的文本内容

```shell
echo -e "line1 f2 f3\nline2 f4 f5\nline3 f6 f7" | awk '{ print "line:"NR",fields="NF, "$0="$0, "$1="$1, "$2="$2, "$3="$3 }'
```
```
line:1,fields=3 $0=line1 f2 f3 $1=line1 $2=f2 $3=f3
line:2,fields=3 $0=line2 f4 f5 $1=line2 $2=f4 $3=f5
line:3,fields=3 $0=line3 f6 f7 $1=line3 $2=f6 $3=f7
```
打印每一行的第二，第三个字段
```shell
awk '{ print $2, $3}' file
```
统计行数
```shell
awk 'END{print NR}' file
```
将每一行第一个字段值相加
```shell
seq 5 | awk 'BEGIN{sum=0; print "求和"} {print $i"+"; sum+=$1} END{print "=="; print sum}'
```

### 将外部变量值传递给awk
```shell
VAR=10
echo | awk -v VAR1=$VAR '{print VAR1}'
```
或者
```shell
var1=hello;var2=didi
echo | awk '{print v1,v2}' v1=$var1 v2=$var2
```
输入来自于文件
```shell
awk '{print v1,v2}' v1=1 v2=2 test
```
读取一行
```shell
seq 5 | awk 'BEGIN{getline; print "read first number="$0} {print $0}'
```
使用过滤模式对awk 处理的行进行过滤
- awk 'NR < 5' 行号小于5的好
- awK 'NR==1,NR==4' 行号在1-5之前的行
- awk '/linux/' 包含linux 的行
- awk '!/linux/' 不包含linux 的行

设置字段定界符
```shell
awk -F: '{print NF}' /et/passwd
```
or
```shell
awk 'BEGIN={iFS=":"} {print $0}' /etc/passwd
```
从awk 中读取命令输出
```shell
"command" | getline output
```
```shell
echo | awk '{"grep root /etc/passwd" | getline cmdout; print cmdout;}' 
```
使用for 循环
```shell
for(i=0;i<10;i++){print $i;}
```
or
```shell
for( i in array) {
  print array[i]
}
```
### awk 内置的函数
- length(str) 
- index(str, search_str) 首次出现的位置
- split(str,array,delimiter) 分割字符串，保存到array中
- substr(str, start-pos,end-pos) 返回子串
- sub(regex,replace_str,str), 替换满足正则的第一个文本
- gsub(regex,replace_str,str), 全部替换满足正则的文本
- match(reges,str) 检查表达式是否匹配字符串

## 4.7 统计特定文件中的词频
// todo 有问题
```shell
if [ $# -ne 1 ]; then
    echo "Usage : $0 filename";
    exit 1
fi

filename="$1"

if [ ! -f "$filename" ]; then
    echo "Error: File $filename does not exist."
    exit 1
fi

egrep -o "\b[[:alpha:]]+\b" "$filename" | awk '{count[$0]++} 
END{printf("%-14s%s\n", "Word", "Count")};
for (index in count) {
  printf("%-14s%d\n", index, count[index]};
} 
'
```

