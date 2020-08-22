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
    }a
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
