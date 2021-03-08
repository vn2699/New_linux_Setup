#! /bin/bash

passwd=$1

wget https://golang.org/dl/go1.16.linux-amd64.tar.gz
echo $passwd | sudo -S tar -C /usr/local -xzf go1.16.linux-amd64.tar.gz
echo $passwd | sudo -S echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
