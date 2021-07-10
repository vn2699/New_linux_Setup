#! /bin/bash

distro=("fedora" "ubuntu" "debian")
os=$1
passwd=$2
cd ~/

if [ "$os" = "fedora" ]
then

	echo $passwd | sudo -S dnf groupinstall 'Development Tools'
	echo $passwd | sudo -S dnf install libcurl-devel
	echo $passwd | sudo -S dnf install sqlite-devel
	curl -fsS https://dlang.org/install.sh | bash -s dmd
	echo $passwd | sudo -S dnf install libnotify-devel

	source ~/dlang/dmd-*/activate
elif [ "$os" = "ubuntu" ] || [ "$os" = "debian" ]
then
	echo $passwd | sudo -S apt install build-essential
	echo $passwd | sudo -S apt install libcurl4-openssl-dev
	echo $passwd | sudo -S apt install libsqlite3-dev
	echo $passwd | sudo -S apt install pkg-config
	echo $passwd | sudo -S apt install git
	echo $passwd | sudo -S apt install curl
	curl -fsS https://dlang.org/install.sh | bash -s dmd
fi

git clone https://github.com/abraunegg/onedrive.git
cd onedrive
./configure
make clean; make;
sudo make install
echo "sync_dir = \"/home/varun/Documents/ACC_Projects\"" >> ~/.config/onedrive/config
onedrive
onedrive --display-config
onedrive --synchronize --verbose --dry-run
