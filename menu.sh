#!/bin/bash
#Menu
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )
up=$(uptime|awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }')
echo -e "------------------------------------------------------------------------------"
echo -e "\e[032;1mCPU model:\e[0m $cname"
echo -e "\e[032;1mNumber of cores:\e[0m $cores"
echo -e "\e[032;1mCPU frequency:\e[0m $freq MHz"
echo -e "\e[032;1mTotal amount of ram:\e[0m $tram MB"
echo -e "\e[032;1mTotal amount of swap:\e[0m $swap MB"
echo -e "\e[032;1mSystem uptime:\e[0m $up"
echo -e "\e[032;1mInstaler By:\e[0m \e[037;1mDey Agustian\e[0m"
echo -e "\e[032;1mAll Supported By:\e[0m \e[037;1mWrgSGntng\e[0m"
echo -e "------------------------------------------------------------------------------"
echo -e "\e[037;1mKONFIGURASI SERVER 	:" 
echo -e "\e[031;1m+ open SSH [22, 444]"
echo -e "\e[032;1m+ dropbear [109, 110, 22507, 53]"
echo -e "\e[033;1m+ SSL/TLS [443]"  
echo -e  "\e[034;1m+ squid3 [80, 8080]"  
echo -e  "\e[035;1m+ badvpn-udpgw [7300]"  
echo -e  "\e[036;1m+ webmin [http://$MYIP:10000/]"  
echo -e  "\e[031;1m+ timezone [Asia/Jakarta (GMT \e[032;+7]"  
echo -e  "\e[032;1m+ IPv6 [off]"  
echo -e "------------------------------------------------------------------------------"
echo -e  "\e[037;1mCOMMAND LIST 	:"  
echo -e  "\e[033;1mx menampilkan command list/daftar perintah [mymenu]"  
echo -e  "\e[034;1mx membuat akun baru [myusernew]"  
echo -e  "\e[035;1mx membuat akun trial berdurasi 1 hari [mytrial]"  
echo -e  "\e[036;1mx mengahpus akun ssh [delete]"  
echo -e  "\e[031;1mx memeriksa user yang login [check]"  
echo -e  "\e[032;1mx memeriksa daftar user [myuser]"  
echo -e  "\e[033;1mx restart service dropbear, webmin, squid3, ssh, & OpenVPN [rest-service]"  
echo -e  "\e[034;1mx reboot server [reboot]"  
echo -e  "\e[035;1mx test speed server [myspeed]" 
echo -e  "\e[036;1mx informasi server [myserver-info]"  
echo -e  "\e[036;1mx informasi script [about-script]"  
echo -e "------------------------------------------------------------------------------"
echo -e  "\e[031;1mBuilder : Dey Agustian"  
echo -e  "\e[032;1mThx to  : Fornesia, Rzengineer, Fawzya"  
echo -e "------------------------------------------------------------------------------"
