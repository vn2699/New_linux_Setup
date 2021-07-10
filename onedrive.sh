#! /bin/bash

distro=("fedora" "ubuntu" "debian")
os=$1
passwd=$2
cd ~/

if [ "$os" = "fedora" ]
then

	echo $passwd | sudo -S dnf groupinstall 'Development Tools' -y
	echo $passwd | sudo -S dnf install libcurl-devel -y
	echo $passwd | sudo -S dnf install sqlite-devel -y
	curl -fsS https://dlang.org/install.sh | bash -s dmd
	echo $passwd | sudo -S dnf install libnotify-devel -y

	source ~/dlang/dmd-*/activate
elif [ "$os" = "ubuntu" ] || [ "$os" = "debian" ]
then
	echo $passwd | sudo -S apt install build-essential -y
	echo $passwd | sudo -S apt install libcurl4-openssl-dev -y
	echo $passwd | sudo -S apt install libsqlite3-dev -y
	echo $passwd | sudo -S apt install pkg-config -y
	echo $passwd | sudo -S apt install git -y
	echo $passwd | sudo -S apt install curl -y
	curl -fsS https://dlang.org/install.sh | bash -s dmd
fi

git clone https://github.com/abraunegg/onedrive.git
cd onedrive
./configure
make clean; make;
sudo make install
onedrive
cat <<EOF > ~/.config/onedrive/config
# Configuration for OneDrive Linux Client
# This file contains the list of supported configuration fields
# with their default values.
# All values need to be enclosed in quotes
# When changing a config option below, remove the '#' from the start of the line
# For explanations of all config options below see docs/USAGE.md or the man page.
#
# sync_dir = "/home/varun/Documents/ACC_Projects"
# skip_file = "~*|.~*|*.tmp"
# monitor_interval = "300"
# skip_dir = ""
# log_dir = "/var/log/onedrive/"
# drive_id = ""
# upload_only = "false"
# check_nomount = "false"
# check_nosync = "false"
# download_only = "false"
# disable_notifications = "false"
# disable_upload_validation = "false"
# enable_logging = "false"
# force_http_2 = "false"
# local_first = "false"
# no_remote_delete = "false"
# skip_symlinks = "false"
# debug_https = "false"
# skip_dotfiles = "false"
# dry_run = "false"
# min_notify_changes = "5"
# monitor_log_frequency = "5"
# monitor_fullscan_frequency = "10"
# sync_root_files = "false"
# classify_as_big_delete = "1000"
# user_agent = ""
# remove_source_files = "false"
# skip_dir_strict_match = "false"
# application_id = ""
# resync = "false"
# bypass_data_preservation = "false"
# azure_ad_endpoint = ""
# azure_tenant_id = "common"
# sync_business_shared_folders = "false"
# sync_dir_permissions = "700"
# sync_file_permissions = "600"
# rate_limit = "131072"
EOF
onedrive --display-config
onedrive --synchronize --verbose --dry-run
