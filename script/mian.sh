#!/bin/sh

# 下载规则
curl -o i-1.txt https://raw.githubusercontent.com/hululu1068/AdGuard-Rule/main/rule/domain.txt
curl -o i-2.txt https://code.gitlink.org.cn/api/v1/repos/keytoolazy/adblock/raw/adblock_lite
curl -o i-3.txt https://code.gitlink.org.cn/damengzhu/abpmerge/raw/branch/main/abpmerge.txt
curl -o i-4.txt https://raw.githubusercontent.com/sjhgvr/oisd/main/abp_basic.txt
curl -o i-5.txt https://raw.githubusercontent.com/samyansan/Ad-hosts/master/adguard
curl -o i-6.txt https://raw.githubusercontent.com/Crystal-RainSlide/AdditionalFiltersCN/master/CN.txt
curl -o i-7.txt https://raw.githubusercontent.com/samyansan/AdRules-SamYan/main/Rules/adguardhome.txt
curl -o i-8.txt https://raw.githubusercontent.com/samyansan/AdRules-SamYan/main/Rules/regex.txt
curl -o i-9.txt https://www.kbsml.com/wp-content/uploads/adblock/adguard/adg-kall.txt
curl -o i-10.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_38.txt
curl -o i-11.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_24.txt

# 合并规则并去除重复项
cat i*.txt > i-mergd.txt
cat i-mergd.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^\[' | grep -v '^\【' | grep -v '^@' | grep -v '^@ ' | grep -v '^###############################################################################################' | grep -v '^############################################################################################### ' | grep -v '^###################################' | grep -v '^################################### ' > i-tmpp.txt
sort -n i-tmpp.txt | uniq > i-tmp.txt

python rule.py i-tmp.txt

# 计算规则数
num=`cat i-tmp.txt | wc -l`

# 添加标题和时间
echo "[Adblock Plus 3.0]" >> i-tpdate.txt
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
