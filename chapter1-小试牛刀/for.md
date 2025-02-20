## 各种循环

双括号有计算的作用
```shell
n=5
for (( i = 0; i < $n; i++ )); do
   echo $i 
done
```
```shell
for i in {1..5} ; do
    echo $i
done
```
```shell
for fruit in apple balana orage;
do
  echo $fruit
done  
```
```shell
for i in ${seq 1 5} ; do
    echo $i
done
```
文件列表遍历
```shell
for file in *;do
  if [ -f "$file" ]; then
      echo $file
  fi
done  
```
```shell
x=0
until [ $x -eq 5 ]; do
  let x++
  echo $x
done
```