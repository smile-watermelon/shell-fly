## 5.2 web页面下载
```shell
wget url url2 ...
```
- -O 指定输出文件名
- -o 将下载std 输出写到日志，日志文件名
- -t 指定重试次数 0 表示一直重试
- --limit-rate 20k，限制下载的速率
- -Q 100m，最大下载的配额
- -c 断点处继续下载
- --mirror --convert-links，遍历网页的所有连接，下面全部的页面
- -l 指定页面层级，-r 递归，这两个需要一起使用
- -N 使用文件的时间戳
- -k 或 -convert-links 将页面的连接转换为本地地址
- --user username --password pass url

## 5.4 CURL
```shell
curl url
```
- --silent 静默下载
- -O 下载数据输出到文件
- --progress 显示进度条
- -C offset，断点续传
- -C - , 自动推断断点续传的位置
- --referer 上一个页面
- --cookie "user=gaugua;age=18"
- -u user:pass
- -I 或 --head 只打印响应头信息

