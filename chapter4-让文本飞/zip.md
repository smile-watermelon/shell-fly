## 4.8 压缩或解压javascript

```shell
cat<<EOF> samle.js
function sign_out() {
  \$("#login").show();
  \$.get("log_in", {logout:"true"}, 
  function() {
    window.location="";
  })
}
EOF
```
- sed 's:/\*.*\*/::g' 匹配注释，并替换为空
- sed 's/ \?\([{}();,:]\) \?/\1/g' 匹配 {,},(,),;,: 任意一个的符号前面的空格，然后删除
```shell
cat sample.js | tr -d '\n\t' | tr -s ' ' | sed 's:/\*.*\*/::g' | sed 's/ \?\([{}();,:]\) \?/\1/g'
```

## 4.9 合并多个文件
cat 通常是按照行来拼接，paste 按照列来拼接
```shell
paste file1 file2 ...
```
```shell
cat<<EOF > file1.txt
1
2
3
4
EOF
```
```shell
cat<<EOF > file2.txt
linux
gun
bash
hack
EOF
```
指定定界符 -d 
```shell
paste file1.txt file2.txt -d "," 
```

## 4.11 打印行或样式之间的文本

打印M 行到N行之间的内容
```shell
awk 'NR==M,NR==N' filename
```
```shell
cat filename | awk 'NR==M,NR==4'
```
打印处于start_pattern, end_pattern 之间的文本
```shell
awk '/start_pattern/, /end_pattern/' filename
```

```shell
cat<<EOF > section.txt
line with pattern1
line with pattern2
line with pattern3
line end pattern4
line with pattern5
EOF
```

```shell
awk '/pa.*3/,/end/' section.txt
```
逆序打印，默认是\n 分割符，-s 指定分割符 
```shell
tac file1 file2 ...
```
```shell
seq 5 | tac
```

## 对目录中的所有文件进行文本替换
- -I 指定替换的字符串
```shell
find . -name *.cpp -print0 | xargs -I {} -0 sed -i 's/Copyright/Copyleft/g' {} 
```
只替换一个文件的
```shell
find . -name "*.cpp" -exec sed -i 's/Copyright/Copyleft/g' \{\}; 
```
替换全部文件的
```shell
find . -name "*.cpp" -exec sed -i 's/Copyright/Copyleft/g' \{\} \+ ;
```

## 替换变量中的部分文本
```shell
var="This is a line of text"
echo ${var/line/Replace}
```
指定字符串的起始位置和长度生成子串

- ${var:start_pos:length}

```shell
str=abcdefg
echo ${str:2:3}
```

从后往前
```shell
str=abcdefg
echo ${str:(-3):2}
```