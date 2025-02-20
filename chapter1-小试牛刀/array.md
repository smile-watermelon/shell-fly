## 1.7.2

定义数组，索引从0开始
```shell
array_var=(1 2 3)
```
定义key=value
```shell
array_var[0]="test1"
array_var[1]="test2"
array_var[2]="test3"
```

- 打印数组元素，这里echo ${array_var[0]} 没有打印出$0
- ${array_var[*]} 打印所有数据
- ${#array_var[*]} 打印数组元素个数
```shell
array_var[0]="test1"
array_var[1]="test2"

echo ${array_var[0]}

echo ${array_var[*]}
echo ${array_var[@]}
echo ${#array_var[*]}
```

- 关联数组
声明
```shell
declare -A ass_array
ass_array={[index1]=val1 [index2]=val2}
# 没有输出
echo ${ass_array[index1]}

ass_array[index1]=v1
ass_array[index2]=v2

echo ${!ass_array[*]}
echo ${!ass_array[@]}
```

```shell
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
```

