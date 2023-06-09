#!/bin/sh

# 下载规则
curl -o i-1.txt https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_224_Chinese/filter.txt
curl -o i-2.txt https://www.kbsml.com/wp-content/uploads/adblock/adguard/adg-kall.txt
curl -o i-3.txt https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt
curl -o i-4.txt https://raw.githubusercontent.com/xndeye/adblock_list/main/rule/dns.txt

# 合并规则并去除重复项
cat i*.txt > i-mergd.txt
cat i-mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^||||' | grep -v '^|||| ' | grep -v '^|||' | grep -v '^||| ' | grep -v '^0.0.0.0' | grep -v '^0.0.0.0 ' | grep -v '^127.0.0.1' | grep -v '^127.0.0.1 ' | grep -v '^## ' | grep -v '^## ' | grep -v '^\[' | grep -v '^\【' | grep -v '^@' | grep -v '$ghide' > i-tmpp.txt
sort -n i-tmpp.txt | uniq > i-tmp.txt

python rule.py i-tmp.txt

# 计算规则数
num=`cat i-tmp.txt | wc -l`

# 添加标题和时间
echo "[Adblock Plus 2.0]" >> i-tpdate.txt
echo "! Title: AdGuard Rules" >> i-tpdate.txt
echo "! Powerd by SamSan" >> i-tpdate.txt
echo "! Description: Just a merged Adblock rule. Nothing more" >> i-tpdate.txt
echo "! Expires: 6 hours (update frequency)" >> i-tpdate.txt
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
