# 一些测试

### 机器测试
```
单线程测试
bash <(curl -Lso- https://bench.im/hyperspeed)
```
```
Bench.sh
wget -qO- bench.sh | bash
```
```
最全测速脚本
curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast
```
```
硬盘
curl -sL yabs.sh | bash -s -- -ig
```
### 网络测试
```
显示延迟、抖动
bash <(wget -qO- https://bench.im/hyperspeed)
```
```
直接显示回程线路(root)
curl https://raw.githubusercontent.com/zhucaidan/mtr_trace/main/mtr_trace.sh | bash
```
```
BestTrace
curl -Lo besttrace https://github.com/chika0801/tool/raw/main/besttrace && chmod +x besttrace
```
```
三网测速
bash <(curl -Lso- https://git.io/superspeed_uxh)
```
```
四网测速
wget -O jcnf.sh https://raw.githubusercontent.com/Netflixxp/jcnfbesttrace/main/jcnf.sh
```
```
流媒体解锁
脚本适配OS: CentOS 6+, Ubuntu 14.04+, Debian 8+, MacOS, Android (Termux), iOS (iSH)
bash <(curl -L -s check.unlock.media)
```
```
奈飞测试
wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.5/nf_2.5_linux_amd64 && chmod +x nf && clear && ./nf
```

### 综合测试
```
CPU 信息、Geekbench 等：
bash <(wget --no-check-certificate -O- https://dl.233.mba/d/sh/superbenchpro.sh)
```
