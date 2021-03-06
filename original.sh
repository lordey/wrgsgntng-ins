#!/bin/bash
#
# Builder Dey Agustian
# Thx to fornesia, rzengineer and fawzya
# ==================================================

# update dan upgrade
apt-get -y update && apt-get -y upgrade

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

#detail nama perusahaan
country=ID
state=WestJava
locality=Majalengka
organization=WarungSiGanteng
organizationalunit=IT
commonname=DeyAgustian
email=admin@warungsiganteng.com

# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/sources.list.debian7"
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# update
apt-get update

# install neofetch
echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list
curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray" -o Release-neofetch.key && sudo apt-key add Release-neofetch.key && rm Release-neofetch.key
apt-get update
apt-get install neofetch
echo "clear" >> .bashrc
echo 'echo -e "Selamat datang di server $HOSTNAME"' >> .bashrc
echo 'echo -e ""' >> .bashrc
echo "clear" >> .bashrc
echo " " >> .bashrc
echo 'echo -e ""' >> .bashrc

# install badvpn
cd
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/lordey/badvpn/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/lordey/badvpn/master/badvpn-udpgw64"
fi
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# setting port ssh
cd
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 444' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=109/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 110 -p 22507 -p 53"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

# install squid3
cd
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install webmin
cd
apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget https://raw.githubusercontent.com/lordey/memek/master/webmin_1.870_all.deb
dpkg --install webmin_1.870_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
rm -f webmin_1.870_all.deb
service webmin restart

# install stunnel
apt-get install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1


[dropbear]
accept = 443
connect = 127.0.0.1:109

END

#membuat sertifikat
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

#konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

# download script
cd /usr/bin
wget -O menu "https://raw.githubusercontent.com/lordey/wrgsgntng-ins/master/menu.sh"
wget -O usernew "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/trial.sh"
wget -O hapus "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/hapus.sh"
wget -O cek "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/user-login.sh"
wget -O member "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/user-list.sh"
wget -O resvis "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/resvis.sh"
wget -O speedtest "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/info.sh"
wget -O about "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/about.sh"
wget -O 1 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/mymenu.sh"
wget -O 2 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/myusernew.sh"
wget -O 3 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/mytrial.sh"
wget -O 4 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/delete.sh"
wget -O 5 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/check.sh"
wget -O 6 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/myuser.sh"
wget -O 7 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/rest-service.sh"
wget -O 8 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/myspeed.sh"
wget -O 9 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/myserver-info.sh"
wget -O 0 "https://raw.githubusercontent.com/lordey/lolcat-conf/master/about-script.sh"
wget -O 00 "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/reb.sh"
wget -O editbanner "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/editbanner.sh"
wget -O 10 "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/editbanner-lolcat.sh"
wget -O vnstat "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/vnstat.sh"
wget -O 11 "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/vnstat-lolcat.sh"
wget -O 12 "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/opnvpncfg.sh"
wget -O 13 "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/fail2banconf.sh"
wget -O 14 "https://raw.githubusercontent.com/lordey/wrgsgntng-conf/master/userexp.sh"

echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot

chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x cek
chmod +x member
chmod +x resvis
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x 1
chmod +x 2
chmod +x 3
chmod +x 4
chmod +x 5
chmod +x 6
chmod +x 7
chmod +x 8
chmod +x 9 
chmod +x 0
chmod +x 00
chmod +x 10
chmod +x vnstat
chmod +x 11
chmod +x 12
chmod +x 13
chmod +x 14

# swap
dd if=/dev/zero of=/swapfile bs=1024 count=2048k
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab
chmod 0600 /swapfile
free -m

#instal ruby dan lolcat
apt-get -y update && apt-get -y upgrade
sudo apt-get install ruby
gem install lolcat

#instal screenfetch
cd
wget -O /usr/bin/screenfetch "https://raw.githubusercontent.com/lordey/screenfetch/master/screenfetch"
chmod +x /usr/bin/screenfetch
echo "clear" >> .profile
echo "screenfetch | lolcat" >> .profile
echo " " >> .profile
echo "1" >> .profile

# instal vnstat
apt-get -y install vnstat
vnstat -u -i eth0
service vnstat restart

# install fail2ban
apt-get -y install fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
service fail2ban restart

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
service cron restart
service ssh restart
service dropbear restart
service squid3 restart
service webmin restart
service vnstat restart
service fail2ban restart
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# info
clear
echo "------------------------------------------------------------------------------" | tee -a log-install.txt
echo "KONFIGURASI SERVER 	:"  | tee -a log-install.txt
echo "+ Open SSH Port : 22"  | tee -a log-install.txt
echo "+ Dropbear Port : 109, 110, 22507, 53"  | tee -a log-install.txt
echo "+ STunnel Port : 443"  | tee -a log-install.txt
echo "+ Squid3 Port : 80, 8080"  | tee -a log-install.txt
echo "+ Badvpn-udpgw Port : 7300"  | tee -a log-install.txt
echo "+ OpenVPN TCP Port : 1194 (if instaled)"  | tee -a log-install.txt
echo "+ Webmin Port : http://$MYIP:10000/"  | tee -a log-install.txt
echo "+ Timezone : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "+ IPv6 : Off" | tee -a log-install.txt
echo "+ Fail2Ban : ON"   | tee -a log-install.txt
echo "------------------------------------------------------------------------------" | tee -a log-install.txt
echo "COMMAND LIST 	:"  | tee -a log-install.txt
echo "[1]  - Show List Command"  | tee -a log-install.txt
echo "[2]  - Create New Account"  | tee -a log-install.txt
echo "[3]  - Create Trial Accout For 1 Day"  | tee -a log-install.txt
echo "[4]  - Delete Account"  | tee -a log-install.txt
echo "[5]  - Checking Login Account"  | tee -a log-install.txt
echo "[6]  - Checking List Account"  | tee -a log-install.txt
echo "[7]  - Restart Service"  | tee -a log-install.txt
echo "[8]  - Speedtest Server"  | tee -a log-install.txt
echo "[9]  - Server Information"  | tee -a log-install.txt
echo "[10] - Edit Banner"  | tee -a log-install.txt
echo "[11] - Checking Bandwidth"  | tee -a log-install.txt
echo "[12] - Show OpenVPN Configuration (if instaled)"  | tee -a log-install.txt
echo "[13] - Edit Fail2ban Configuration (for security)"  | tee -a log-install.txt
echo "[14] - Tag User Expired"  | tee -a log-install.txt
echo "[0]  - Script Information"  | tee -a log-install.txt
echo "[00] - Reboot Server"  | tee -a log-install.txt
echo "Write the number + enter for execution..." | tee -a log-install.txt
echo "------------------------------------------------------------------------------" | tee -a log-install.txt
echo "Builder : Dey Agustian"  | tee -a log-install.txt
echo "Thx to  : Fornesia, Rzengineer, Fawzya"  | tee -a log-install.txt
echo "------------------------------------------------------------------------------" | tee -a log-install.txt
cd
rm -f /root/debian7.sh
