#!/bin/bash

banner()
{
echo -e "\e[20mSubDomains Brute Forcer\e[0m"
echo -e "\e[20mUsage:./SubDomains.sh domain.com list.txt" 
echo -e "\e[35m------------------------------------\e[0m"
echo
}

banner

if [ "$#" -ne 2 ]; then
   echo -e "Illegal number of parameters"
   exit 1
fi

domain=$1
list=$2
total=$(wc -l $list | cut -d' ' -f1)
file="$domain.$(date +%Y%m%d).txt"

# Colors 
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "\e[12m$total Loaded...\e[0m"
echo -e "\e[20mStart: $(date)\e[0m"
echo -e "\e[35m------------------------------------\e[0m"


for i in $(cat $list); do
        server="$i.$domain"
        result="$(host $server | grep -e 'has address' | cut -d' ' -f4 )"


        if [ "$result" ]; then
                echo -e "${GREEN}[+] VALID:${NC} $i.$domain: $result"
                echo -e "$i.$domain: $result" >> $file
        fi
done


echo -e "\e[35m------------------------------------\e[0m"
echo -e "\e[20mEnd: $(date)\e[0m"
