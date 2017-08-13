   18  sudo apt-get install gdebi-core
   19  sudo gdebi bcompare-4.2.2.22384_amd64.deb
   20  apt install python3 python3-dev python3-pip
   21  apt install python python-dev python-pip
   22  rm -v bcompare-4.2.2.22384_amd64.deb
   26  apt install -y shellcheck bashate flake8 pep8 frosted pylama cppcheck
   27  apt install -y shellcheck flake8 pep8  cppcheck
   28  sudo apt-get install neovim
   29  sudo add-apt-repository ppa:neovim-ppa/stable
   30  sudo apt-get update
   31  sudo apt-get install neovim
   32  sudo apt-get install python-neovim python3-neovim -y
   36  sudo apt-get install neovim --remove
   37  sudo apt-get remove neovim 
   38  sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y
   39  git clone https://github.com/neovim/neovim.git
   40  cd neovim/
   41  git tag
   42  git checkout -v v0.2.0
   43  git checkout v0.2.0
   44  make CMAKE_BUILD_TYPE=Release
   45  ls -lat build/bin/nvim 
   46   build/bin/nvim -v
   47   build/bin/nvim -v | grep FO
   48   build/bin/nvim -v | grep py
   49  cd ../
   50  rm -rf neovim/
   51  sudo apt-get install neovim 
   53  sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
   54  sudo update-alternatives --config vi
   57  sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
   58  sudo update-alternatives --config vim
   62  python3 -v
   63  sudo pip3 install --upgrade neovim
   64  pip install --upgrade pip
   65  sudo pip3 install --upgrade neovim
   71  aptitude clean
   72  apt install aptitude
   73  aptitude clean
   94  git clone https://github.com/alexbriskin/my_scripts.git
  103  mv my_scripts/ home/
  112  cd home/alexb/
  113  ls -la
  114  cat <<EOF >> .bashrc 
source ./my_scripts/aliases.sh
source \$MYSCRIPTS/my_bashrc 
EOF

  122  sudo apt-get install -y python-pip
  123  sudo apt-get install -y python1-pip
  124  sudo apt-get install -y python2-pip
  125  sudo apt-get install -y python3-pip
  130  realpath  ~/.config/nvim/i
  131  rm ~/.config/nvim/i
  132  rm ~/.config/nvim/i -rvf
  133  mv ./.bashrc ~
  134  mv -v my_scripts/ ~
  135  mkdir -p ~/.config/nvim/
  136  cd ~
  137  lt
  138  lt -a
  139  source ./.bashrc 
  140  ln -sf  ~/my_scripts/init.vim ~/.config/nvim/
  141  lt ~/.config/nvim/
  142  vim
  143  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  144  lt ~/.local/share/nvim/site/autoload/plug.vim
  145  vim
  146  arm ~/.local/share/nvim/
  147  curl -fLo ~/.config/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  148  mv -v ~/.config/autoload/ ~/.config/nvim/
  149  vi 
  150  fg
  151  pip3 install neovim
  152  pip install neovim
  153  pip3 install --upgrade neovim
  154  pip install --upgrade neovim
  155  fg
  156  apt install -y ruby gem
  157  fg
  158  gem install neovim
  159  gem2.3 install neovim
  160  apt-get install ruby-dev
  161  gem2.3 install neovim
  162  fg
  163  lt ~/.config/nvim/plugged/
  164  fg
  165  lt 
  166  lt -a
  167  cp -rv .bashrc my_scripts .config /etc/skel/ 
  168  lt /etc/skel/
  169  lt /etc/skel/ -a
  170  cd my_scripts/
  171  git status 
  172  git add -u
  173  git commit -m "Update init vim for neovim"
  174  git config user.email 'br.shurik@gmail.com"
  175  git config user.email 'br.shurik@gmail.com'
  176  git config user.name "Alex Briskin"
  177  git commit -m "Update init vim for neovim"
  178  git push 
  179  history | vim -
