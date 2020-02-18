
Вариант 32 

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt install ttf-mscorefonts-installer:i386
sudo apt-get install libmagickwand-6.q16-3:i386
sudo apt-get install libgsf-1-114:i386
sudo apt-get install libwebkitgtk-1.0-0:i386
sudo apt install libgd3:i386
sudo apt install libzip4:i386
sudo apt install libpng16-16:i386
sudo apt install libodbc1:i386

устанавка deb пакетов 1с

		sudo apt-get install -f
или 

скопировать все пакеты в одну папку и там в консоли 

sudo dpkg -i /home/user/soft/ntlmaps_*.deb

sudo dpkg -i   /home/user/1c/32/3/*.deb
               /home/user/1c/32/3

Пример:

user@user-B36M-D3H:~/1c/32/3$ l
1c-enterprise83-client_8.3.15-1565_i386.deb*
1c-enterprise83-common_8.3.15-1565_i386.deb*
1c-enterprise83-server_8.3.15-1565_i386.deb*

user@user-B36M-D3H:~/1c/32/3$ pwd
/home/user/1c/32/3

user@user-B36M-D3H:~/1c/32/3$ sudo dpkg -i /home/andrew/1c/32/3/*.deb
