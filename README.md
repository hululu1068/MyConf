# 一些测试

### [融合怪](https://virt.spiritlhl.net/case/case2.html)测试
```
交互式
curl -L https://github.com/spiritLHLS/ecs/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh
```
### 科技lion—键脚本工具
```
支持Debian系
curl -sS -O https://kejilion.pro/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh
```

### 机器性能测试
```
单线程测试
bash <(curl -Lso- https://bench.im/hyperspeed)
```
```
Bench.sh
wget -qO- bench.sh | bash
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
```
Bench.sh (轻量)
wget -qO- bench.sh | bash
```
```
LemonBench-Next (全面)
wget -qO- https://raw.githubusercontent.com/LemonBench/LemonBench/main/LemonBench.sh | bash -s -- --fast
```
