#!/bin/bash

# $0 	当前脚本的文件名。params.sh
# $n（n≥1） 	传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是 $1，第二个参数是 $2。
# $# 	传递给脚本或函数的参数个数。
# $* 	传递给脚本或函数的所有参数。
# $@ 	传递给脚本或函数的所有参数。当被双引号" "包含时，$@ 与 $* 稍有不同，我们将在《Shell $*和$@的区别》一节中详细讲解。
# $? 	上个命令的退出状态，或函数的返回值，我们将在《Shell $?》一节中详细讲解。
# $$ 	当前 Shell 进程 ID。对于 Shell 脚本，就是这些脚本所在的进程 ID。
PRG="$0"
ls=`ls -ld "$PRG"`
# 获取软连接文件的真实文件名，params.sh
link=`expr "$ls" : '.*-> \(.*\)$'`
echo $link

echo `dirname "$PRG"`

echo "$_RUNJAVA"
echo "$JAVA_OPTS"
#echo "$ls"
#echo $0
#echo $1
#echo $#
#echo $*
#echo "$@"
#echo $?
#echo $$
