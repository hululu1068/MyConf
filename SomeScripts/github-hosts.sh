#!/bin/bash

# GitHub hosts链接地址
url="https://raw.hellogithub.com/hosts"

# 配置文件、Title
echo "# Title: GitHub Hosts" > github-hosts.conf
echo "# Update: $(date '+%Y-%m-%d %H:%M:%S')" >> github-hosts.conf

# 转化
curl -s "$url" | grep -v "^\s*#\|^\s*$" | awk '{print "address /"$2"/"$1}' >> github-hosts.conf

# 移动到SmartDNS目录下
# mv github-hosts.conf /etc/smartdns/domain-set/

exit 0
