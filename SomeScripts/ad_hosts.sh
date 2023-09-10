#!/bin/bash

# 将hosts格式转换为smartdns支持的格式

wget -cN https://cdn.jsdelivr.net/gh/hululu1068/AdRules@main/hosts.txt -O /tmp/ad_hosts.txt
cat /tmp/ad_hosts.txt | grep -v "^#" | awk '{print "address /"$2"/0.0.0.0"}' > /etc/smartdns/domain-set/ad_hosts.conf

exit 0