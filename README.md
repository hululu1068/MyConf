# 一些测试
### CPU

```
curl -sL yabs.sh | bash -s -- -fi
```

### 硬盘

```
curl -sL yabs.sh | bash -s -- -ig
```

### 回程路由

BestTrace

```
curl -Lo besttrace https://github.com/chika0801/tool/raw/main/besttrace && chmod +x besttrace
```

```
./besttrace IP
```

```
./besttrace --tcp IP
```

NextTrace

```
curl -Lo nexttrace https://github.com/sjlleo/nexttrace/releases/latest/download/nexttrace_linux_amd64 && chmod +x nexttrace
```

```
./nexttrace -T -table IP
```

```
./nexttrace -U -table IP
```

MTR

```
apt install -y mtr
```

```
mtr --tcp --psize 1400 IP
```

```
mtr --udp --psize 1400 IP
```

### 流媒体解锁

```
bash <(curl -L -s check.unlock.media)
```

或

```
curl -Lo nf https://github.com/sjlleo/netflix-verify/releases/download/v3.1.0/nf_linux_amd64 && curl -Lo ytb https://github.com/sjlleo/TubeCheck/releases/download/1.0Beta/tubecheck_1.0beta_linux_amd64 && chmod +x nf ytb
```

```
./nf && ./ytb
```

### 测速

```
curl -sL https://raw.githubusercontent.com/chika0801/tool/main/speedtest.sh | bash
```

或

```
curl -Lo speedtest https://github.com/chika0801/tool/raw/main/speedtest && chmod +x speedtest
```

```
./speedtest -s 服务器ID
```

