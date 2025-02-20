## 2.4 玩转xargs

xargs 将标准输入转换成命令行参数，单行变多行，多行变单行
- command | xargs

多行转换为单行，用空格替代
```shell
cat file.txt | xargs
```
单行转换为多行，-n 指定每行参数数量
```shell
cat file1.txt | xargs -n 2
```
使用自定义定界符，分割文本
```shell
echo "hello#shell" | xargs -d "#" -n 1
```
给脚本传递参数
```shell
echo "1 2 3" | xargs -n 1 ./xargs.sh
```
循环执行xargs，{} 花括号用来做占位符
```shell
echo '1 2 3' | xargs -I {} ./xargs.sh -p {} -1
```
执行命令行的做个参数
```shell
cat file.txt | ( while read arg; do cat $arg; doen )
```
等同于
```shell
cat file.txt | xargs -I {} cat {}
```

## 2.6 用tr 进行转换
tr set1 set2 ，将从stdin 的输入字符从set1 映射到set2，如果set1 和set2 的字符长度不相同，set2 会不断重复其最后一个字符，直到长度与set1相同
如果set2 的长度大于set1,set2超出的长度会被忽略

对数字进行加密
```shell
echo 12345 | tr '0-9' '9876543210'
```
解密
```shell
echo 87654 | tr '9876543210' '0-9'
```
替换
```shell
echo '1 2 3' | tr ' ' '#'
```
删除 -d 指定需要被清理的 "字符" 集合
```shell
echo '123abc' | tr -d '0-9'
```
```shell
cat file.txt | tr -d 'f1'
```
获取补集，没有包含在set1内的字符
- tr -c [set1]
```shell
echo hello 1 char 2 next 4 | tr -c -d '0-9 \n' 
```
数字相加
```shell
cat<<EOF>sum.txt
1
2
3
EOF;
```
```shell
cat sum.txt | echo $[ $( tr '\n' '+' ) 0]  
```

## 2.7 校验和与核实
md5，sha1

- md5sum filename
- sha1sum filename
```shell
md5sum file.txt
```

加密工具
1. crypt
- crypt <input_file> > output_file
- crypt passpharse <input_file> > encrypted_file

解密
- crypt passparase -d <encrtpted_file> > output_file

gpg 加码，通常用于邮件签名
- gpg -c filename

解密

- gpg filename.gpg

base64 将二进制文件转换为base64 可读模式

- base64 filename > output_file

或者

- cat file | base64 > output_file

解密

- base64 -d file > output_file

or

- cat base64_file | base64 -d > output_file

推荐使用 bcrypt 或 sha512sum 加密

openssl 生成密码

- openssl passwd -l -salt salt_string passwd