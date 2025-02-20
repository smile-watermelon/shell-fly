
```shell
case $1 in
start)
  echo "server is started..."
  ;;
restart)
  echo "stopping the server $pid"
  echo "starting the server..."
  echo "server is started, pid is ${pid}"
  ;;
stop) ;;

esac
```
