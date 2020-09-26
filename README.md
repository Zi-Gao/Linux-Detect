# Linux-Detect Linux-Detect Linux系统CPU利用率监控程序
新建一个脚本,取名Detect.sh
```bash
vim Detect.sh
```
没有vim的CentOS系列使用
```bash
yum install vim
```
Ubuntu系列用
```bash
apt install vim
```

输入
```bash
#!/bin/bash
while true
do
CPU=0
for((i=1;i<=10;i++));
do
CpuIdle=$(vmstat 1 5 | sed -n '3,$p' | awk '{x = x + $15} END {print x/5}' | awk -F. '{print $1}')
CpuNum=$(echo "100-$CpuIdle" | bc)
if [ $CpuNum -gt 80 ]; then
	{
		CPU = $[$CPU + 1]
		echo "$(date +[%Y-%m-%d-%H-%M-%S])BAD"
	}
else
	{
		echo "$(date +[%Y-%m-%d-%H-%M-%S])OK"
	}
fi
done
if [ $CPU -gt 8 ]; then
{
	echo "$(date +[%Y-%m-%d-%H-%M-%S])STOP"
	//放入你的 停止网站 or 服务器的命令
}
else
    {
       echo "$(date +[%Y-%m-%d-%H-%M-%S])$((10-$CPU))OK"
    }
fi
done
```

## 原理解释

不想看的就去部署吧

```bash
#!/bin/bash
while true
//无限循环
do
//循环开始
CPU=0
//记录十次统计中多少次系统CPU利用率超过80%
for((i=1;i<=10;i++));
//循环十次
do
//循环开始
CpuIdle=$(vmstat 1 5 | sed -n '3,$p' | awk '{x = x + $15} END {print x/5}' | awk -F. '{print $1}')
CpuNum=$(echo "100-$CpuIdle" | bc)
//将CPU利用转换成数字 如:16 (%)
if [ $CpuNum -gt 80 ]; then
//是否超过80%
	{
		CPU = $[$CPU + 1]
		//CPU值加一
		echo "$(date +[%Y-%m-%d-%H-%M-%S])BAD"
		//输出日志
	}
else
	{
		echo "$(date +[%Y-%m-%d-%H-%M-%S])OK"
		//输出日志
	}
fi
//if结束
done
//十次循环结束
if [ $CPU -gt 8 ]; then
{
	echo "$(date +[%Y-%m-%d-%H-%M-%S])STOP"
	//放入你的 停止网站 or 服务器的命令
}
else
    {
       echo "$(date +[%Y-%m-%d-%H-%M-%S])$((10-$CPU))OK"
       //$((10-$CPU))将多少次超过80%转换为多少次没超过80 输出日志
    }
fi
//if结束
done
//无限循环结束
//$(date +[%Y-%m-%d-%H-%M-%S])为输出时间,如 [2020-08-22-20-52-52] 
```
