# 一些测试

### 机器性能测试
```
融合怪
curl -L https://github.com/spiritLHLS/ecs/raw/main/ecs.sh -o ecs.sh && chmod +x ecs.sh && bash ecs.sh
```
```
Bench.sh
wget -qO- bench.sh | bash
```
```
硬盘
curl -sL yabs.sh | bash -s -- -ig
```
### IP质量检测
```
bash <(curl -Ls http://IP.Check.Place)
```
![image](https://github.com/user-attachments/assets/85f801c0-ca06-40e4-aeb5-47a97ff4c216)

### 网络测试
```
BestTrace
curl -Lo besttrace https://github.com/chika0801/tool/raw/main/besttrace && chmod +x besttrace
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
