#!/bin/sh

# 下载规则
curl -o i-1.txt https://raw.githubusercontent.com/damengzhu/banad/main/jiekouAD.txt
curl -o i-2.txt https://filters.adtidy.org/extension/ublock/filters/224.txt
curl -o i-3.txt https://raw.githubusercontent.com/o0HalfLife0o/list/master/ad.txt
curl -o i-4.txt https://www.i-dont-care-about-cookies.eu/abp/
curl -o i-5.txt https://easylist-downloads.adblockplus.org/antiadblockfilters.txt
curl -o i-6.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/adblock.txt
curl -o i-7.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt
curl -o i-8.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_38.txt
curl -o i-9.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_5.txt
curl -o i-10.txt https://www.kbsml.com/wp-content/uploads/adblock/adguard/adg-kall.txt
curl -o i-11.txt https://raw.githubusercontent.com/hululu1068/AdGuard-Rule/main/rule/adgh.txt
curl -o i-12.txt https://raw.githubusercontent.com/samyansan/AdRules-SamYan/main/Rules/dns.txt

# 合并规则并去除重复项
cat i*.txt > i-mergd.txt
cat i-mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' > i-tmpp.txt
sort -n i-tmpp.txt | uniq > i-tmp.txt

python rule.py i-tmp.txt

# 计算规则数
num=`cat i-tmp.txt | wc -l`

# 添加标题和时间
echo "[Adblock Plus 2.0]" >> i-tpdate.txt
echo "! Title: AdGuard Rules" >> i-tpdate.txt
echo "! Description: 该规则合并自各位大神规则以及补充的规则" >> i-tpdate.txt
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
