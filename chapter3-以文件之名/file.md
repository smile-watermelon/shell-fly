## 3.2 生成任意大小的文件

# dd 命令：从各种输入终端复制数据到输出终端（文件，标准输出等，设备文件）
- if 输入数据源，of 输出数据，bs 输出多大字节，count 输出几次，总大小是 bs * count
if 不传默认从stdin 输入
```shell
dd if=/dev/zero of=junk.data bs=1M count=1
```

## 3.3 文件的交集和差集
```shell
cat<<EOF>a.txt
apple
orage
gold
silver
steel
iron
EOF
```
```shell
cat<<EOF>b.txt
apple
orage
gold
cookies
corret
EOF
```
交集
```shell
sort a.txt -o a.txt ; sort b.txt -o b.txt
```
```shell
comm a.txt b.txt
```
```shell
                apple
        cookies
        corret
                gold
iron
                orage
silver
steel

```
第一列只在a文件中出现，第二列只在b文件出现，第三列a,b都有
打印交集，删除1，2列
```shell
comm a.txt b.txt -1 -2
```
打印不相同的行
```shell
comm a.txt b.txt -3
```
生成规范的输出
sed 's' substitute 替换，^表示行首
```shell
comm a.txt b.txt -3 | sed 's/^\t//'
```
a 文件的差集
```shell
comm a.txt b.txt -2 -3
```
b 文件的差集
```shell
comm a.txt b.txt -1 -3 
```

## 3.4 查找并删除重复文件
```shell
echo "hello" > test; cp test test_copy1; cp test test_copy2;
echo "next" > other;
```

awk 首先读取第一行，第一行是计数，丢弃，再读取第二行，保存第二行的文件名，及大小给到
变量name1,size
第一个if 判断是不是文件大小相等，然后计算校验和，如果校验和相等，则两个文件相等
```shell
ls -lS --time-style=long-iso | awk 'BEGIN {
  getline; getline;
  name1=$9; size=$5
  echo $name1 $size
}
{
  name2=$9;
  if(size==$5)
  { 
      "md5sum "name1 | getline; csum1=$1;
      "md5sum "name2 | getline; csum2=$1;
      if (csum1==csum2)
      {
          print name1; print name2
      }
  }
  size=$5; name1=name2;
}' | sort -u > duplicate_files

cat duplicate_files | xargs -I {} md5sum {} | sort | uniq -w 32 | awk '{print $2}' | 
sort -u > duplicate_sample

echo removing...
comm duplicate_files duplicate_sample -2 -3 | tee /dev/stderr | xargs rm

echo removed duplicates files successfunlly.
```
- -lS 以长格式列出文件并按照文件大小进行排序