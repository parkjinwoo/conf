conf
====

.vimrc

# [pathogen](https://github.com/tpope/vim-pathogen "pathogen")

    mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -Sso ~/.vim/autoload/pathogen.vim \
        https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# [nerdtree](https://github.com/scrooloose/nerdtree "nerdtree")

    cd ~/.vim/bundle
    git clone https://github.com/scrooloose/nerdtree.git

# [Vim Bundle](https://github.com/parkjinwoo/conf/tree/my-vim-bundle "vim bundle")

	cd ~/.vim/bundle
    git clone -b my-vim-bundle https://github.com/parkjinwoo/conf.git myvim

# git config

    git config --global user.name "name"
    git config --global user.email id@email.com
    git config --global core.editor vim
    git config --global color.ui true

    find / -type f -name "git-completion.bash" -print
