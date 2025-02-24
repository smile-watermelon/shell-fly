## 6.2 tar 归档

- -c 创建归档文件
- -f 指定归档文件名
- -v 显示详细信息
- -r 向归档文件中添加一些文件
- -t 列出归档压缩包里的文件
- -x 解压提取文件
- -C 指定解压目录
- -A 拼接两个归档文件
- -u 更新压缩包中文件，只有修改过的才会被更新
- -d 打印两者之间的区别
- --delete 删除文件
- -z gzip
- -j zip2 
- --lzma lzma格式
- -X 排除一些文件
- --exclude-vcs 排除版本控制相关文件
- -a 自动检测压缩格式


tar -cf output.tar [SOURCES]

tar -cf output.tar file1 file2

```shell
tar -rvf outpur.tar other... 
```
这里的 - 是将压缩文件输出到标准输出，
```shell
tar cvf - files/ | ssh user@example.com "tar xv -C Documents/"
```
拼接file2到file1
```shell
tar -Af file1.tar file2.tar
```
file 相对上次添加到归档文件后发生了变化才追加
```shell
tar -uf archive.tar file
```
区别
```shell
tar -df archive.tar
```
删除 file
```shell
tar --delete --file archive.tar file
```
归档时排除一些文件
```shell
tar -cf arch.tar * --exclude "*.txt"
```
或者
```shell
cat list
file1
file2
```
```shell
tar -cf arch.tar * -X list
```

## 6.8 rsync 备份系统快照
- -a 归档
- -v 显示详情
- -z 网络传输时压缩数据
- --exclude PATTERN，排除文件
- --delete 删除目的端不存在于源端的文件

```shell
rsync -av source_path des_path
```
```shell
rsync -av /home/guagua/data guagua@192.168.0.6:/home/guagua/bak
```
