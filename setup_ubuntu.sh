#!/bin/bash -eu

sudo dpkg --add-architecture i386
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt install -y dkms virtualbox-guest-dkms git vim curl cscope \
	thunar minicom mate-terminal xclip realpath cmake doxygen \
	u-boot-tools atftp ssh g++ make mercurial pandoc \
	openjdk-9-jre-headless smitools meld atftpd ssh g++ make mercurial \
	pandoc openjdk-9-jre-headless smitools meld atftpd xinetd \
	libgtk2.0-0:i386 libxtst6:i386 wget dfu-util emacs wireshark sshfs \
	repo tree autofs clang clang-tidy cppcheck flawfinder pylint pylint3 \
	flake8 pep8 pychecker shellcheck libc6:i386 lib32z1 libncurses5:i386 \
	libstdc++6:i386 gdebi-core qemu python neovim python-dev python-pip \
	python3-dev python3-pip gem libffi-dev libssl-dev libxml2-dev \
	libxslt1-dev libjpeg8-dev zlib1g-dev ruby-dev python2.7-dev \
	libncurses5-dev libelf-dev quilt exuberant-ctags

sudo touch /var/log/atftpd.log
sudo chmod 644 /var/log/atftpd.log
[ ! -f /etc/default/atftpd ] && cat <<EOF | sudo tee /etc/default/atftpd
USE_INETD=false
OPTIONS="--tftpd-timeout 300 --retry-timeout 5 --mcast-port 1758 --mcast-addr 239.239.239.0-255 --mcast-ttl 1 --maxthread 100 --verbose=5 /tftpboot --logfile /var/log/atftpd.log"
EOF

git config --global core.editor "vim"
wget https://www.scootersoftware.com/bcompare-4.2.2.22384_amd64.deb
sudo gdebi bcompare-4.2.2.22384_amd64.deb

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
sudo pip install mitmproxy
sudo pip install neovim
sudo pip3 install neovim
sudo gem install neovim
curl -fLo /root/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
