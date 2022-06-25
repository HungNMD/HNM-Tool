#!/bin/bash

#wget https://hostingaz.vn/script/hztut/2017/hnm -O /tmp/hnm && chmod +x /tmp/hnm  && /tmp/hnm 

echo "========================================================================="
echo "Nhap mat khau khi truy cap Remote Desktop VPS bang phan mem tren May tinh"
echo "-------------------------------------------------------------------------"
echo "Mat khau toi thieu 8 ki tu va chi bao gom chu cai va so"
echo "-------------------------------------------------------------------------"
echo -n "Nhap mat khau VNCServer: "
read PASS1
if [ "$PASS1" = "" ]; then
clear
echo "========================================================================="
echo "Ban chua nhap mat khau"
echo "========================================================================="
echo "========================================================================="
echo "========================================================================="
./hnm
exit
fi
checkpass="^[a-zA-Z0-9_][-a-zA-Z0-9_]{0,61}[a-zA-Z0-9_]$";
if [[ ! "$PASS1" =~ $checkpass ]]; then
clear
echo "========================================================================="
echo "Ban chi duoc dung chu cai va so de dat mat khau."
echo "========================================================================="
echo "========================================================================="
echo "========================================================================="
./hnm
exit
fi

if [[ ! ${#PASS1} -ge 8 ]]; then
clear
echo "========================================================================="
echo "Dat mat khau that bai. Mat khau toi thieu 8 ky tu."
echo "-------------------------------------------------------------------------"
echo "Ban hay nhap lai  !"
echo "========================================================================="
echo "========================================================================="
echo "========================================================================="
./hnm
exit
fi  

echo "-------------------------------------------------------------------------"
echo -n "Nhap lai mat khau [ENTER]: " 
read PASS2
if [ "$PASS1" != "$PASS2" ]; then
clear
echo "========================================================================="
echo "Mat khau ban nhap hai lan khong giong nhau !"
echo "-------------------------------------------------------------------------"
echo "Ban hay nhap lai"
echo "========================================================================="
echo "========================================================================="
echo "========================================================================="
./hnm
exit
fi 
echo "$PASS1" > /tmp/pass
clear
printf "================================================================================\n"
printf "Dat mat khau hoan thanh. Bay gio HZTUT se tu dong cai dat giao dien Desktop,\n"
printf "================================================================================\n"
printf "VNCserver va cac phan mem can thiet cho VPS\n"
printf "================================================================================\n"
printf "================================================================================\n"
sleep 4

clear
echo "========================================================================="
echo "Tao Swap File."; sleep 2

sudo dd if=/dev/zero of=/swapfile bs=1024 count=1024k
sudo mkswap /swapfile
sudo swapon /swapfile
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile
sudo echo "/swapfile    none    swap    sw    0    0" >> /etc/fstab
sudo apt-get -y update
sudo apt-get -y upgrade --force-confold
sudo mkdir -p /root/.vnc/
echo "head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13" > /root/.vnc/passwd
sudo chmod 600 /root/.vnc/passwd

sudo apt-get -y install xorg lxde-core tightvncserver

vncpasswd -f <<< $(cat /tmp/pass) > "/root/.vnc/passwd"

#clear
#printf "========================================================================\n"
#printf "Dat mat khau khi Remote Desktop VPS\n"
#printf "========================================================================\n"
#printf "\n"
#printf "\n"
#tightvncserver :1
clear
printf "========================================================================\n"
printf "Da cai dat xong vncserver cho VPS... \n"
printf "========================================================================\n"
printf "Bay gio hztut se cai dat cac chuong trinh can thiet de VPS hoat dong.\n"
printf "=========================================================================\n"
sleep 5

sudo apt-get install -y wget rar unrar zip unzip p7zip p7zip-full xarchiver file-roller filezilla nano
clear
echo "========================================================================="
echo "Dung command: [ unzip abc.zip ] va [ unrar x abc.rar ] de giai nen file "; sleep 6
clear
echo "========================================================================="
echo "Cai dat trinh duyet giao dien Desktop, Firefox & Chromium "; sleep 3
sudo apt-get install -y flashplugin-install -yer
sudo apt-get install -y xpad nano firefox chromium-browser filezilla
sudo apt-get install -y ibus-unikey
sudo ibus restart
vncserver -kill :1

# Cau hinh Chromium chay voi user root:


sudo sed -i "s/\#CHROMIUM_FLAGS=\"--password-store=detect\"/CHROMIUM_FLAGS=\"--user-data-dir\"/g" /etc/chromium-browser/default 

sudo mv /root/.vnc/xstartup /root/.vnc/xstartup.bak

wget -q https://hostingaz.vn/script/hztut/lxde-u/xstartup -O /root/.vnc/xstartup
wget -q http://hostingaz.vn/script/hztut/default.png -O /usr/share/lxde/wallpapers/lxde_blue.jpg
chmod +x /root/.vnc/xstartup
sed -i '/wallpaper=/d' ~/.config/pcmanfm/LXDE/desktop*.conf
echo "wallpaper=/usr/share/lxde/wallpapers/lxde_blue.jpg" >> ~/.config/pcmanfm/LXDE/desktop*.conf
checkversion=$(lsb_release -r | awk '{ print $2 }')
if [ $checkversion \> 17 ];
then 
sudo cat > "/etc/systemd/system/tigervnc114.service" <<END
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple
User=root
PAMName=root
PIDFile=/root/.vnc/%H%i.pid
ExecStart=/usr/bin/vncserver:1
ExecStop=/usr/bin/vncserver -kill %i

[Install]
WantedBy=multi-user.target
END

systemctl enable tigervnc114.service
systemctl daemon-reload 
else
sudo wget -q http://hostingaz.vn/script/hztut/vncserver1 -O /etc/init.d/vncserver1
sudo chmod +x /etc/init.d/vncserver1
update-rc.d vncserver1 defaults
fi;
vncserver
clear
echo "========================================================================"
echo "Hoan tat qua trinh cai dat."
echo "------------------------------------------------------------------------"
echo "Ban da co the su dung phan mem tren may tinh de Remote Desktop Server"
echo "------------------------------------------------------------------------"
echo "Mat khau su dung khi Remote: $(cat /tmp/pass)"
echo "========================================================================"
echo "Server cua ban se reboot sau 3s nua."
rm -rf /tmp/check
rm -rf /root/hnm
rm -rf /root/hnm 
rm -rf /tmp/pass
sleep 3
reboot
exit

