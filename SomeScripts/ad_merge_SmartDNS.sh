#!/bin/bash

# 适用于SmartDNS的广告过滤合并脚本

# 设置三个规则文件的链接地址
url1="https://anti-ad.net/anti-ad-for-smartdns.conf"
url2="https://adrules.top/smart-dns.conf"
url3="https://raw.githubusercontent.com/neodevpro/neodevhost/master/lite_smartdns.conf"

# 设置新文件名
new_file="ad_address.conf"

# 下载三个规则文件并将内容合并到新文件中,sort去重排序
echo "Generating ad_address.conf..."
echo "# Generated at $(date '+%Y-%m-%d %H:%M:%S')" > "$new_file"
(curl -s "$url1" | grep -o 'address \/[^\/]*\/#' ) \
  && (curl -s "$url2" | grep -o 'address \/[^\/]*\/#' ) \
  && (curl -s "$url3" | grep -o 'address \/[^\/]*\/#' ) \
  | sort -u >> "$new_file"
# 统计规则数量
rule_count=$(grep -c 'address \/' "$new_file")

# 在新文件的第二行添加规则数量信息（MacOS和类unix平台需调整）
sed -i "2i # $rule_count rules" "$new_file"

sed -i "3i # getting from $url1" "$new_file"
sed -i "4i # getting from $url2" "$new_file"
sed -i "5i # getting from $url3" "$new_file"

echo "Done!"