conf
====

.vimrc

# [pathogen](https://github.com/tpope/vim-pathogen "pathogen")

    mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# [nerdtree](https://github.com/scrooloose/nerdtree "nerdtree")

    cd ~/.vim/bundle
    git clone https://github.com/scrooloose/nerdtree.git

# [Vim Bundle](https://github.com/parkjinwoo/conf/tree/my-vim-bundle "vim bundle")

	cd ~/.vim/bundle
    git clone -b my-vim-bundle https://github.com/parkjinwoo/conf.git myvim

# [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh "oh my zsh")

    brew install zsh
    echo "/usr/local/bin/zsh" >> /etc/shells
    chsh -s /usr/local/bin/zsh

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# git config

    git config --global user.name "name"
    git config --global user.email id@email.com
    git config --global core.editor vim
    git config --global color.ui true
    git config --global alias.ll "log --graph --all --format=format:'%C(blue)%h%C(reset) %C(yellow)%d%C(reset) %C(green)%s%C(reset) %C(red)(%ar)%C(reset) %C(bold cyan)— %an%C(reset)' --abbrev-commit --date=relative"

    find / -type f -name "git-completion.bash" -print
