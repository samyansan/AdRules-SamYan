#!/bin/sh

# 下载规则
curl -o i-1.txt https://raw.githubusercontent.com/ookangzheng/dbl-oisd-nl/master/abp_light.txt
curl -o i-2.txt https://code.gitlink.org.cn/damengzhu/abpmerge/raw/branch/main/abpmerge.txt
curl -o i-3.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/adblock_lite.txt
curl -o i-4.txt https://code.gitlink.org.cn/api/v1/repos/keytoolazy/adblock/raw/adblock_lite
curl -o i-5.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt
curl -o i-6.txt https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt
curl -o i-7.txt https://o0.pages.dev/mini/adblock.txt
curl -o i-8.txt https://raw.githubusercontent.com/zsakvo/AdGuard-Custom-Rule/master/rule/zhihu.txt
curl -o i-9.txt https://raw.githubusercontent.com/samyansan/AdRules-SamYan/main/Rules/adguardhome.txt

# 合并规则并去除重复项
cat i*.txt > i-mergd.txt
cat i-mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > i-tmpp.txt
sort -n i-tmpp.txt | uniq > i-tmp.txt

python rule.py i-tmp.txt

# 计算规则数
num=`cat i-tmp.txt | wc -l`

# 添加标题和时间
echo "[Adblock Plus 2.0]" >> i-tpdate.txt
echo "! Title: ABP Merge Rules" >> i-tpdate.txt
echo "! Description: 该规则为合并规则" >> i-tpdate.txt
echo "! Version: `date +"%Y-%m-%d %H:%M:%S"`" >> i-tpdate.txt
echo "! Total count: $num" >> i-tpdate.txt
cat i-tpdate.txt i-tmp.txt > ad.txt

cat "ad.txt" | grep \
-e "\(^\|\w\)#@\?#" \
-e "\(^\|\w\)#@\??#" \
-e "\(^\|\w\)#@\?\$#" \
-e "\(^\|\w\)#@\?\$?#" \
> "CSSRule.txt"

# 删除缓存
rm i-*.txt

#退出程序
exit
