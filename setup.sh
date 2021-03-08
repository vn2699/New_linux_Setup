#! /bin/bash

passwd=$2
os=$1

if [ "$#" -le 1 ]
then
	echo "Enter the right arguments"
fi

if [ "$os" != "debian" ] || [ "$os" != "redhat" ] || [ "$os" != "ubuntu"  ]
then
	echo "Enter the right distro for which you want to setup"
	echo "Enter argument as debian or redhat!!!"
fi

if [ "$os" = "redhat" ]
then
	echo $passwd | sudo -S dnf update && sudo -S dnf upgrade -y 
	echo $passwd | sudo -S dnf install vim
	echo $passwd | sudo -S hostnamectl set-hostname --static vn2699
	echo $passwd | sudo -S dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
	echo $passwd | sudo -S dnf groupupdate core -y
	echo $passwd | sudo -S dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
	echo $passwd | sudo -S dnf groupupdate sound-and-video -y
	echo $passwd | sudo -S dnf install rpmfusion-free-release-tainted -y
	echo $passwd | sudo -S dnf install libdvdcss -y
	echo $passwd | sudo -S dnf install rpmfusion-nonfree-release-tainted -y
	echo $passwd | sudo -S dnf install \*-firmware -y
	echo $passwd | sudo -S dnf install openssl -y
	./nvidia.sh $passwd
	cp .gitmessage.txt ~/.gitmessage.txt
        cp .gitconfig ~/.gitconfig
	echo $passwd | sudo -S dnf install mutt -y
	./mutt.sh
	cp ./.muttrc ~/.muttrc
	mkdir -p ~/.mutt/cache
	echo $passwd | sudo -S flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	./go.sh $passwd
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	echo $passwd | sudo -S ./aws/install
	echo $passwd | sudo -S dnf -y install dnf-plugins-core
	echo $passwd | sudo -S dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
	echo $passwd | sudo -S sudo dnf install docker-ce docker-ce-cli containerd.io -y
	echo $passwd | sudo -S systemctl start docker
	echo $passwd | sudo -S systemctl enable docker
	echo $passwd | sudo -S usermod -aG docker varun
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	echo $passwd | sudo -S install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	echo $passwd | sudo -S mv /tmp/eksctl /usr/local/bin
	echo $passwd | sudo -S dnf install gnome-tweaks -y
	
elif [ "$os" = "ubuntu" ]
then
	#echo "Under Construction!!!!"
	echo $passwd | sudo -S apt update
	echo $passwd | sudo -S apt upgrade
	cp .gitmessage.txt ~/.gitmessage.txt
	cp .gitconfig ~/.gitconfig
	echo $passwd | sudo -S apt install mutt -y
	./mutt.sh
        cp ./.muttrc ~/.muttrc
        mkdir -p ~/.mutt/cache
	./go.sh $passwd
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
	echo $passwd | sudo -S ./aws/install
	echo $passwd | sudo -S apt-get install \
    	apt-transport-https \
    	ca-certificates \
    	curl \
    	gnupg-agent \
    	software-properties-common -y
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
	echo $passwd | sudo -S add-apt-repository \
   	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   	$(lsb_release -cs) \
   	stable"
	echo $passwd | sudo -S apt-get update
	echo $passwd | sudo -S sudo apt-get install docker-ce docker-ce-cli containerd.io -y
	echo $passwd | sudo -S systemctl start docker
        echo $passwd | sudo -S systemctl enable docker
        echo $passwd | sudo -S usermod -aG docker varun
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        echo $passwd | sudo -S install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
        echo $passwd | sudo -S mv /tmp/eksctl /usr/local/bin

elif [ "$os" = "debian" ]
then
	echo $passwd | su root
	/sbin/usermod -aG sudo varun
	echo $passwd | su varun
	#echo "Under Construction!!!!"
        echo $passwd | sudo -S apt update
        echo $passwd | sudo -S apt upgrade
        cp .gitmessage.txt ~/.gitmessage.txt
        cp .gitconfig ~/.gitconfig
        echo $passwd | sudo -S apt install mutt -y
        ./mutt.sh
        cp ./.muttrc ~/.muttrc
        mkdir -p ~/.mutt/cache
        ./go.sh $passwd
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        echo $passwd | sudo -S ./aws/install
        echo $passwd | sudo -S apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg -y
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
       
	echo \
  	"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        echo $passwd | sudo -S apt-get update
        echo $passwd | sudo -S sudo apt-get install docker-ce docker-ce-cli containerd.io -y
        echo $passwd | sudo -S systemctl start docker
        echo $passwd | sudo -S systemctl enable docker
        echo $passwd | sudo -S usermod -aG docker varun
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        echo $passwd | sudo -S install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
        echo $passwd | sudo -S mv /tmp/eksctl /usr/local/bin
	source ~/.bashrc
fi

echo $passwd | sudo -S reboot
