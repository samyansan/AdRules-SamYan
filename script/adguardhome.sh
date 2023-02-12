#!/bin/bash
cd /root/adblist          #脚本的路径
# 下载广告规则源
wget -O i1.txt https://www.kbsml.com/wp-content/uploads/adblock/adguard/adg-kall-dns.txt
wget -O i2.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/dns.txt
wget -O i3.txt https://adguardteam.github.io/HostlistsRegistry/assets/filter_21.txt
wget -O i4.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/thrid-part-rules.txt
wget -O i5.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt
wget -O i6.txt https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/adblock-rules.txt
# 合并与删除重复项
cat i*.txt > mergd.list
cat mergd.list | grep '^|' > block.list
cat mergd.list | grep '^@' > allow.list
cat mergd.list | grep '^/' > exclude.list
cat exclude.list block.list allow.list > tmpp.list
sort -n tmpp.list | uniq > tmp.list
 
# 计数规则
num=`cat tmp.list | wc -l`
# 添加标题与日期
echo "! Version: `date +"%Y-%m-%d %H:%M:%S" `" >> tpdate.list
echo "! Total count: $num" >> tpdate.list
cat file_header.name tpdate.list tmp.list > final.list
mv final.list /root/adblist/adguardhome.txt
echo "规则以自动生成，当前规则有"
cat tmp.list | wc -l
rm -rf *.list
rm -rf i*.txt
exit