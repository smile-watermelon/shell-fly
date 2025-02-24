## 4.5 sed 文本替换

```shell
sed 's/pattern/replace/' file
```
or
```shell
cat file | sed 's/pattern/replace_str/'
```
只替换第一个replace_str
```shell
sed 's/pattern/replace_str/' file > newfile
```
替换后修改文件
```shell
sed -i 's/pattern/replace/' file 
```
全部替换
```shell
sed 's/pattern/replace/g' file
```
从匹配的第N个文本开始替换
```shell
echo 'thisthisthisthis' | sed 's/this/hello/2g' 
```
删除空白行 d
```shell
sed '/^$/d' file
```
修改原文件，并备份,i.bak 之间不能有空格
```shell
sed -i.bak 's/abc/edf' file
```
标记匹配到文本 [this] [is] [an] [example]
```shell
echo this is an example | sed 's/\w\+/[&]/g'
```
子串标记 \1，将digit 7 替换为7，\(\) 用于匹配子串，第二个子串是\2，一次类推
```shell
echo this is digit 7 in a number | sed 's/digit \([0-9]\)/\1/'
```
多个表达式
```shell
sed 'expression' | sed 'repression'
```
等价于
```shell
sed 'expression; expression'
```
or
```shell
sed -e 'expression' -e 'expression'
```
```shell
echo abc | sed 's/a/A/' | sed 's/c/C/'
```

```shell
text=hello
echo hello world | sed "s/$text/HELLO/"

```

