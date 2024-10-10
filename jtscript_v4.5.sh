#!/bin/bash

#-------VARIABLES-------
RED='\033[31m' # Kırmızı
BLUE='\033[34m' # Mavi
YELLOW='\033[33m' # Sarı
GREEN='\033[32m' # Yeşil
NC='\033[0m' # Renksiz
VER='V4.5' # Sürüm Bilgisi
CONCACT='+90 537 240 59 22'

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    DISTRO=$NAME
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    DISTRO=$(lsb_release -si)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    DISTRO=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    DISTRO=Debian
else
    DISTRO=$(uname -s)
fi
#-------VARIABLES-------


#--------ANA MENU--------
header() {
	clear
	echo -e "$BLUE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$NC"	
	echo -e "$RED->" "$GREEN""Jeteron $REDÇok Amaçlı Kurulum Aracı <-$NC"
	echo -e "Script Sürümü            :$GREEN $VER $NC"
	echo -e "Kullanılan Linux Dağıtımı:$GREEN $DISTRO $NC"
	echo -e "İletişim                 :$GREEN $CONCACT $NC"
	echo -e "$BLUE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	}	
ana_menu() {
	echo -e "$YELLOW 1) -$NC TeaSpeak Menu"
	echo -e "$YELLOW 2) -$NC TeamSpeak3 Menu"
	echo -e "$YELLOW 3) -$NC TeamSpeak3 Crack Menu (Yapım Aşamasında!)"
	echo -e "$YELLOW 4) -$NC SinusBot Menu (Geliştiriliyor ama kullanılabilir.)"
	echo -e "$YELLOW 5) -$NC JTS3 Menu (Yapım Aşamasında!)"
	echo -e "$YELLOW 6) -$NC Çıkış\n"
}
ana_siklar(){
	local choice
	read -p "[ 1 - 6] Arası seçim yapın : " choice
	case $choice in
		1) teaspeak_menu ;;
		2) teamspeak_menu ;;
#		3) teamspeak_crack_menu ;;
		4) sinusbot_menu ;;
#		5) jts3_menu ;;
		6) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}
#--------ANA MENU--------

#-------TEASPEAK MENU-------
teaspeak_menu() {

teaspeak_ana_menu() {
	echo -e "$YELLOW 1) -$NC TeaSpeak Yönetim"
	echo -e "$YELLOW 2) -$NC TeaSpeak Kur"
	echo -e "$YELLOW 3) -$NC TeaSpeak Beta Kur"
	echo -e "$YELLOW 4) -$NC Linuxkurulum Data Transfer"
	echo -e "$YELLOW 5) -$NC Çıkış\n"
}

teaspeak_ana_siklar(){
	local choice
	read -p "[ 1 - 5] Arası seçim yapın : " choice
	case $choice in
		1) teaspeak_yonet ;;
		2) teaspeak_kur ;;
		3) teaspeak_kur_beta ;;
		4) teaspeak_linuxkurulum ;;
		5) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}

teaspeak_yonet() {
teaspeak_yonetim_ana_menu() {
	echo -e "$YELLOW 1) -$NC İlk Başlatma"
	echo -e "$YELLOW 2) -$NC Başlat"
	echo -e "$YELLOW 3) -$NC Durdur"
	echo -e "$YELLOW 4) -$NC Servis olarak ekle - Yeni"
	echo -e "$YELLOW 5) -$NC Protocol Key Yenile"
	echo -e "$YELLOW 6) -$NC Çıkış\n"
}

teaspeak_yonetim_siklar(){
	local choice
	read -p "[ 1 - 5] Arası seçim yapın : " choice
	case $choice in
		1) teaspeak_ilk ;;
		2) teaspeak_baslat ;;
		3) teaspeak_durdur ;;
		4) teaspeak_systemd ;;
		5) teaspeak_protocol ;;
		6) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}
teaspeak_ilk() {
./TeaSpeak/teastart_minimal.sh
}
teaspeak_baslat() {
service teaspeak start
}
teaspeak_systemd() {
curl -o /lib/systemd/system/teaspeak.service https://raw.githubusercontent.com/erdembekci/teaspeak-conf/main/teaspeak.service
systemctl enable teaspeak.service
}
teaspeak_protocol(){

if [ -e "/lib/systemd/system/teaspeak.service" ]; then
    echo "TeaSpeak servisi durduruluyor..."
	service teaspeak stop
    truncate -s 0 /root/TeaSpeak/protocol_key.txt
cat << EOF > TeaSpeak/protocol_key.txt
# Teaspeak Protocol Key
# Expiration date: 30/01/2025
version:0
chain:AQCvbHFTQDY/terPeilrp/ECU9xCH5U3xC92lYTNaY/0KQAJFueAazbsgAAAACVUZWFtU3BlYWsgU3lzdGVtcyBHbWJIAABYyYX7FX5HpmIVNjbxgaJFtgNAzMQsrJQpLGHw0F8FWgAUzCoiOtyVfgAAACRUZWFtU3BlYWsgc3lzdGVtcyBHbWJIAABKcH1NdoizqcGieuNp1GDuhqn8YU3nAR0UidjKXyJcKQIU1hUAFriaAAYAAAAAV29ybGQA
root_key_prv:aJuEx+w9sOAjN+5wooeoC3ujE27Wqsy3j5sCoOFcp2E=
root_key_pbl:zQ3irtRjRVCafjz9j2iz3HVVsp3M7HPNGHUPmTgSQIo=
root_prv_index:3

EOF
	echo "TeaSpeak servisi başlatılıyor..."
service teaspeak start
else
 echo "TeaSpeak durduruluyor..."
	/root/TeaSpeak/teastart.sh stop
    truncate -s 0 /root/TeaSpeak/protocol_key.txt
cat << EOF > TeaSpeak/protocol_key.txt
# Teaspeak Protocol Key
# Expiration date: 30/01/2025
version:0
chain:AQCvbHFTQDY/terPeilrp/ECU9xCH5U3xC92lYTNaY/0KQAJFueAazbsgAAAACVUZWFtU3BlYWsgU3lzdGVtcyBHbWJIAABYyYX7FX5HpmIVNjbxgaJFtgNAzMQsrJQpLGHw0F8FWgAUzCoiOtyVfgAAACRUZWFtU3BlYWsgc3lzdGVtcyBHbWJIAABKcH1NdoizqcGieuNp1GDuhqn8YU3nAR0UidjKXyJcKQIU1hUAFriaAAYAAAAAV29ybGQA
root_key_prv:aJuEx+w9sOAjN+5wooeoC3ujE27Wqsy3j5sCoOFcp2E=
root_key_pbl:zQ3irtRjRVCafjz9j2iz3HVVsp3M7HPNGHUPmTgSQIo=
root_prv_index:3

EOF
	echo "TeaSpeak başlatılıyor..."
/root/TeaSpeak/teastart.sh start
fi
}
teaspeak_durdur() {
service teaspeak stop
}
while true
do
	header
	teaspeak_yonetim_ana_menu
	teaspeak_yonetim_siklar
done
}
teaspeak_linuxkurulum() {
if [ "$uid" = "0" ]
  then 
  if (mv /usr/local/.lkserver/.serverts/TeaData.sqlite /root/TeaSpeak/TeaData.sqlite
mv /usr/local/.lkserver/.serverts/files /root/TeaSpeak/files )
then
echo -e "\033[32mVeriler geri yüklendi."
else
echo -e "\033[31mVeriler geri yüklenemedi."
fi
  else
    if (sudo mv /usr/local/.lkserver/.serverts/TeaData.sqlite ~/TeaSpeak/TeaData.sqlite
sudo mv /usr/local/.lkserver/.serverts/files ~/TeaSpeak/files )
then
echo -e "\033[32mVeriler geri yüklendi."
else
echo -e "\033[31mVeriler geri yüklenemedi."
fi
fi
}
teaspeak_kur_beta() {

TEA_VERSION=$(curl -s --connect-timeout 10 -S -L -k https://repo.teaspeak.de/server/linux/amd64_optimized/latest)
TEA_REQUEST_URL="https://repo.teaspeak.de/server/linux/amd64_optimized/TeaSpeak-${TEA_VERSION}.tar.gz"

echo -e "\033[34mTeaSpeak indiriliyor..."
mkdir TeaSpeak
if (curl "${TEA_REQUEST_URL}" --output teaspeak.tar.gz)
then
if [ -f /etc/redhat-release ]; then
  systemctl stop firewalld
  systemctl disable firewalld
fi

if [ -f /etc/lsb-release ]; then
  apt-get install screen
fi
tar -zxf teaspeak.tar.gz -C TeaSpeak/
curl "https://raw.githubusercontent.com/erdembekci/teaspeak-conf/main/config.yml" --output TeaSpeak/config.yml
cat << EOF > TeaSpeak/protocol_key.txt
# Teaspeak Protocol Key
# Expiration date: 30/01/2025
version:0
chain:AQCvbHFTQDY/terPeilrp/ECU9xCH5U3xC92lYTNaY/0KQAJFueAazbsgAAAACVUZWFtU3BlYWsgU3lzdGVtcyBHbWJIAABYyYX7FX5HpmIVNjbxgaJFtgNAzMQsrJQpLGHw0F8FWgAUzCoiOtyVfgAAACRUZWFtU3BlYWsgc3lzdGVtcyBHbWJIAABKcH1NdoizqcGieuNp1GDuhqn8YU3nAR0UidjKXyJcKQIU1hUAFriaAAYAAAAAV29ybGQA
root_key_prv:aJuEx+w9sOAjN+5wooeoC3ujE27Wqsy3j5sCoOFcp2E=
root_key_pbl:zQ3irtRjRVCafjz9j2iz3HVVsp3M7HPNGHUPmTgSQIo=
root_prv_index:3

EOF
curl "https://raw.githubusercontent.com/erdembekci/teaspeak-conf/main/teastart.sh" --output TeaSpeak/teastart.sh
echo -e "\033[32mTeaSpeak '${TEA_VERSION}' sürümü başarıyla indirildi."
rm -rf teaspeak.tar.gz
else
rm -rf TeaSpeak
echo -e "\033[31mTeaSpeak indirilirken hata oluştu daha sonra tekrar deneyiniz."
fi
}
teaspeak_kur() {

TEA_VERSION=$(curl -s --connect-timeout 10 -S -L -k https://repo.teaspeak.de/server/linux/amd64_stable/latest)
TEA_REQUEST_URL="https://repo.teaspeak.de/server/linux/amd64_stable/TeaSpeak-${TEA_VERSION}.tar.gz"

echo -e "\033[34mTeaSpeak indiriliyor..."
mkdir TeaSpeak
if (curl "${TEA_REQUEST_URL}" --output teaspeak.tar.gz)
then
if [ -f /etc/redhat-release ]; then
  systemctl stop firewalld
  systemctl disable firewalld
fi

if [ -f /etc/lsb-release ]; then
  apt-get install screen
fi
tar -zxf teaspeak.tar.gz -C TeaSpeak/
curl "https://raw.githubusercontent.com/erdembekci/teaspeak-conf/main/config.yml" --output TeaSpeak/config.yml
cat << EOF > TeaSpeak/protocol_key.txt
# Teaspeak Protocol Key
# Expiration date: 30/01/2025
version:0
chain:AQCvbHFTQDY/terPeilrp/ECU9xCH5U3xC92lYTNaY/0KQAJFueAazbsgAAAACVUZWFtU3BlYWsgU3lzdGVtcyBHbWJIAABYyYX7FX5HpmIVNjbxgaJFtgNAzMQsrJQpLGHw0F8FWgAUzCoiOtyVfgAAACRUZWFtU3BlYWsgc3lzdGVtcyBHbWJIAABKcH1NdoizqcGieuNp1GDuhqn8YU3nAR0UidjKXyJcKQIU1hUAFriaAAYAAAAAV29ybGQA
root_key_prv:aJuEx+w9sOAjN+5wooeoC3ujE27Wqsy3j5sCoOFcp2E=
root_key_pbl:zQ3irtRjRVCafjz9j2iz3HVVsp3M7HPNGHUPmTgSQIo=
root_prv_index:3

EOF
curl "https://raw.githubusercontent.com/erdembekci/teaspeak-conf/main/teastart.sh" --output TeaSpeak/teastart.sh
echo -e "\033[32mTeaSpeak '${TEA_VERSION}' sürümü başarıyla indirildi."
rm -rf teaspeak.tar.gz
else
rm -rf TeaSpeak
echo -e "\033[31mTeaSpeak indirilirken hata oluştu daha sonra tekrar deneyiniz."
fi
}
while true
do
	header
	teaspeak_ana_menu
	teaspeak_ana_siklar
done
}
#-------TEASPEAK MENU-------


#-------TEAMSPEAK MENU-------
teamspeak_menu() {
teamspeak_ana_menu() {
	echo -e "$YELLOW 1) -$NC TeamSpeak Yönetim"
	echo -e "$YELLOW 2) -$NC TeamSpeak Kur"
	echo -e "$YELLOW 3) -$NC TeamSpeak Kaldır"
	echo -e "$YELLOW 4) -$NC Çıkış\n"
}
teamspeak_ana_siklar() {
	local choice
	read -p "[ 1 - 6] Arası seçim yapın : " choice
	case $choice in
		1) teamspeak_yonet ;;
		2) teamspeak_kur ;;
		3) teamspeak_kaldir ;;
		4) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}
teamspeak_yonet() {
teamspeak_yonetim_ana_menu() {
	echo -e "$YELLOW 1) -$NC İlk Başlatma"
	echo -e "$YELLOW 2) -$NC Başlat"
	echo -e "$YELLOW 3) -$NC Durdur"
	echo -e "$YELLOW 4) -$NC Çıkış\n"
}

teamspeak_yonetim_siklar(){
	local choice
	read -p "[ 1 - 4] Arası seçim yapın : " choice
	case $choice in
		1) teamspeak_ilk ;;
		2) teamspeak_baslat ;;
		3) teamspeak_durdur ;;
		4) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}
teamspeak_ilk() {
./TeamSpeak/teamspeak3-server_linux_amd64/ts3server_minimal_runscript.sh
}
teamspeak_baslat() {
TeamSpeak/teamspeak3-server_linux_amd64/ts3server_startscript.sh start
}
teamspeak_durdur() {
TeamSpeak/teamspeak3-server_linux_amd64/ts3server_startscript.sh stop
}
while true
do
	header
	teamspeak_yonetim_ana_menu
	teamspeak_yonetim_siklar
done
}
teamspeak_kur() {
mkdir TeamSpeak
if (curl "https://files.teamspeak-services.com/releases/server/3.13.3/teamspeak3-server_linux_amd64-3.13.3.tar.bz2" --output teamspeak.tar.bz2)
then
if [ -f /etc/redhat-release ]; then
  systemctl stop firewalld
  systemctl disable firewalld
fi

if [ -f /etc/lsb-release ]; then
  apt-get install screen
fi 
tar -xjf teamspeak.tar.bz2 -C TeamSpeak/
echo -e "\033[32mTeamSpeak sürümü başarıyla indirildi."
else
rm -rf TeamSpeak
echo -e "\033[31mTeamSpeak indirilirken hata oluştu daha sonra tekrar deneyiniz."
fi
}
teamspeak_kaldir() {
rm -rf TeamSpeak
}
while true
do
	header
	teamspeak_ana_menu
	teamspeak_ana_siklar
done
}
#-------TEAMSPEAK MENU-------


#-------TS3CRACK MENU-------
ts3crack_menu() {
ts3crack_ana_menu() {
	echo -e "$YELLOW 1) -$NC TS3AudioBot Yönetim"
	echo -e "$YELLOW 2) -$NC TS3AudioBot Kur"
	echo -e "$YELLOW 3) -$NC TS3AudioBot Kaldır"
	echo -e "$YELLOW 4) -$NC Çıkış\n"
}

ts3crack_ana_siklar() {
	local choice
	read -p "[ 1 - 6] Arası seçim yapın : " choice
	case $choice in
		1) ts3crack_yonet ;;
		2) ts3crack_kur ;;
		3) ts3crack_kaldir ;;
		4) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}

while true
do
	header
	ts3crack_ana_menu
	ts3crack_ana_siklar
done
}
#-------TS3CRACK MENU-------


#-------SINUSBOT MENU-------
sinusbot_menu() {
sinusbot_ana_menu() {
	echo -e "$YELLOW 1) -$NC SinusBot Yönetim"
	echo -e "$YELLOW 2) -$NC SinusBot Kur"
	echo -e "$YELLOW 3) -$NC SinusBot Kaldır"
	echo -e "$YELLOW 4) -$NC Çıkış\n"
}
sinusbot_ana_siklar() {
	local choice
	read -p "[ 1 - 6] Arası seçim yapın : " choice
	case $choice in
		1) sinusbot_yonet ;;
		2) sinusbot_kur ;;
		3) sinusbot_kaldir ;;
		4) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}
sinusbot_yonet() {
sinusbot_yonetim_ana_menu() {
	echo -e "$YELLOW 1) -$NC Başlat (Başlatmadan önce şifre değiştirin.)"
	echo -e "$YELLOW 2) -$NC Durdur"
	echo -e "$YELLOW 3) -$NC Yeniden Başlat"
	echo -e "$YELLOW 4) -$NC Şifre Değiştir"
	echo -e "$YELLOW 5) -$NC Çıkış\n"
}

sinusbot_yonetim_siklar(){
	local choice
	read -p "[ 1 - 5] Arası seçim yapın : " choice
	case $choice in
		1) sinusbot_baslat ;;
		2) sinusbot_durdur ;;
		3) sinusbot_ybaslat ;;
		4) sinusbot_defpw ;;
		5) exit 0;;
		*) echo -e "${RED}Hatalı Giriş..." && sleep 2
	esac
}
sinusbot_baslat() {
service sinusbot start
}
sinusbot_durdur() {
service sinusbot stop
}
sinusbot_ybaslat() {
service sinusbot restart
}
sinusbot_defpw() {
password=$(openssl rand -base64 16)
sudo -i -u sinusbot  bash << EOF 
cd /opt/sinusbot
echo -e "$YELLOW Şifreyi değiştirmek için http://ipadress:8087 girip admin şifre olarak girmelisiniz"
echo -e "$YELLOW Giriş yaptıktan sonra Settings > User Accounts > admin hesabını düzenleyip yeni şifre belirleyiniz."
echo -e "$YELLOW Belirledikten sonra CTRL + C çekip scripti sonlandırın ve sinusbotu normal başlatın."
echo -e "$YELLOW Geçici Şifreniz: $GREEN$password $NC"
./sinusbot --override-password=$password
EOF
}
while true
do
	header
	sinusbot_yonetim_ana_menu
	sinusbot_yonetim_siklar
done
}
sinusbot_kur() {
if [ -f /etc/redhat-release ]; then
  systemctl stop firewalld
  systemctl disable firewalld
fi

if [ -f /etc/lsb-release ]; then
add-apt-repository universe
apt-get update
apt-get install -y x11vnc xvfb libglib2.0-0 libxcursor1 ca-certificates curl bzip2 libnss3 libegl1-mesa x11-xkb-utils libasound2 libpci3 libxslt1.1 libxkbcommon0 libxss1 libxcomposite1 ca-certificates youtube-dl ffmpeg
fi
adduser --disabled-login sinusbot
mkdir -p /opt/sinusbot
chown -R sinusbot:sinusbot /opt/sinusbot
sudo -i -u sinusbot  bash << EOF
cd /opt/sinusbot
wget http://repo.hostingdunyam.com.tr/Jeteron/Sinusbot/sinusbot.tar
tar -xvf sinusbot.tar
rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so
mkdir TeamSpeak3-Client-linux_amd64/plugins
cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins/
chmod 755 sinusbot
EOF
curl -o /lib/systemd/system/sinusbot.service http://repo.hostingdunyam.com.tr/Jeteron/Sinusbot/sinusbot.service
}
sinusbot_kaldir() {
rm -rf /opt/sinusbot
}
while true
do
	header
	sinusbot_ana_menu
	sinusbot_ana_siklar
done
}
#-------SINUSBOT MENU-------

while true
do
	header
	ana_menu
	ana_siklar
done
