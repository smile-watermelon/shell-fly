# 1.6 玩转文件描述符及重定向
- 0 - stdin 
- 1 - stdout
- 2 - stderr

```shell
# 追加文本
echo "this is sample text 1" >> temp.txt
```
将标准错误和标准输出到文件
```shell
# 分开输出到不同的文件
cmd 2>err.log 1>info.log

cmd  2>&1 out.txt
# 或者
cmd &> out.txt

# 如果不关心错误可以输出到垃圾桶/黑洞
cmd 2>/dev/null
```
- cat -n 将stdin 的每行数据加上行号写入 stdout

- tee 接收stdin 的数据写入到一个文件，不见参数默认是覆盖文件
```shell
cat if.sh | tee if1.sh | cat -n
```
```shell
echo who is this | tee -
```
- > >> , > 会清空文件，>> 是追加
- 读取数据，cmd < file
```shell
# 多行输出，会清空源文件的内容
cat<<EOF>log.txt
LOG file header
guagua
EOF
```
- < 从文件中读取到stdin,> 截断模式的文件写入

创建一个文件描述符进行读取，使用exec

exec 命令用于在当前 Shell 进程中执行指定的命令，执行后会替换当前 Shell 进程，不会创建子 Shell。
一旦执行 exec 命令，当前 Shell 的后续命令将不会再执行。

- exec 3<input.txt
```shell
echo this is a test line > input.txt
exec 3<input.txt
cat<&3
```
创建一个文件描述符写入
```shell
exec 4>out.txt
echo newline >&4
cat out.txt
```
追加模式
```shell
exec 5>>input.txt
echo append lien >&5
cat input.txt
```

