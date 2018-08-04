conf
====

# [pathogen](https://github.com/tpope/vim-pathogen "pathogen")

    mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# [nerdtree](https://github.com/scrooloose/nerdtree "nerdtree")

    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# [Vim Bundle](https://github.com/parkjinwoo/conf/tree/my-vim-bundle "vim bundle")

    git clone -b my-vim-bundle https://github.com/parkjinwoo/conf.git ~/.vim/bundle/myvim

# vimrc

    curl -LSso ~/.vimrc https://github.com/parkjinwoo/conf/raw/master/vimrc

# [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh "oh my zsh")

    brew install zsh
    echo "/usr/local/bin/zsh" >> /etc/shells
    chsh -s /usr/local/bin/zsh
    
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    
    curl -LSso ~/.zshrc https://github.com/parkjinwoo/conf/raw/master/zshrc
    curl -LSso ~/.oh-my-zsh/themes/parkjinwoo.zsh-theme https://github.com/parkjinwoo/conf/raw/master/parkjinwoo.zsh-theme

# git config

    git config --global user.name "${name}"
    git config --global user.email ${email}
    git config --global core.editor vim
    git config --global color.ui true
    git config --global alias.ll "log --graph --all --format=format:'%C(blue)%h%C(reset) %C(yellow)%d%C(reset) %C(green)%s%C(reset) %C(red)(%ar)%C(reset) %C(bold cyan)— %an%C(reset)' --abbrev-commit --date=relative"
