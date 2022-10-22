#!/bin/bash

# Shebang
# Скрипт проверяет доступность ip proxy, для дальнейшего использования одной из главных вариаций 
# подмены ip в приложении

# http_proxy="http://$proxy" wget -qO- eth0.me # Проверяю доступность ip, для ипользования приложения 
# http_proxy="http://$proxy" $application      # подмена ip, для консольного приложения
#
# https_proxy="https://user:pass@proxy:port/" 
# http_proxy="http://user:pass@proxy:port/"
# ftp_proxy="ftp://user:pass@proxy:port/"
# socks_proxy="socks://user:pass@proxy:port/"
# curl -s ipinfo.io

# ./Check_proxy.sh < socks_list.txt

sed '/^$/d' $1 > proxy-list2.txt

for sLine in $(< proxy-list2.txt); do
  export http_proxy="http://$sLine"
  echo "################################"
  echo "Testing $sLine"
  wget --spider --timeout=5 --tries=1 http://www.example.com
  echo "*******************************"
done
rm proxy-list2.txt
