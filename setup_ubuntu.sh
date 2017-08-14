#!/bin/bash -eu

sudo dpkg --add-architecture i386
sudo apt-get update

sudo apt install -y libc6:i386 lib32z1 libncurses5:i386 libstdc++6:i386

sudo apt install -y dkms virtualbox-guest-dkms git vim  curl cscope thunar \
	minicom mate-terminal xclip realpath cmake doxygen u-boot-tools atftp\
	ssh g++ make mercurial pandoc openjdk-9-jre-headless smitools meld atftpd\
	kdiff3 cscope patch libmpc3 ksh libsdl1.2-dev openssh-server telnetd \
	xinetd  libgtk2.0-0:i386 libxtst6:i386 wget dfu-util emacs wireshark \
	sshfs repo tree autofs


sudo touch /var/log/atftpd.log
sudo chmod 644 /var/log/atftpd.log
[ ! -f /etc/default/atftpd ] && cat <<EOF | sudo tee /etc/default/atftpd
USE_INETD=false
OPTIONS="--tftpd-timeout 300 --retry-timeout 5 --mcast-port 1758 --mcast-addr 239.239.239.0-255 --mcast-ttl 1 --maxthread 100 --verbose=5 /tftpboot --logfile /var/log/atftpd.log"
EOF

git config --global core.editor "vim"
apt install -y clang clang-tidy cppcheck flawfinder pylint pylint3 flake8 pep8 pychecker shellcheck
apt install -y cmakelint
wget https://www.scootersoftware.com/bcompare-4.2.2.22384_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.2.2.22384_amd64.deb
