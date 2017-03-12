#!/bin/bash -eu

sudo dpkg --add-architecture i386
sudo apt-get update

sudo apt install -y libc6:i386 lib32z1 libncurses5:i386 libstdc++6:i386

sudo apt install -y dkms virtualbox-guest-dkms git vim  curl cscope thunar \
	minicom mate-terminal xclip realpath cmake doxygen u-boot-tools atftp \
	ssh g++ make mercurial pandoc openjdk-9-jre-headless smitools meld \
	kdiff3 cscope patch libmpc3 ksh libsdl1.2-dev openssh-server telnetd \
	xinetd  libgtk2.0-0:i386 libxtst6:i386

