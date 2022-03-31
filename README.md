conf
====

# vimrc

    mkdir -p ~/.vim/bundle/my/colors ~/.vim/bundle/my/syntax
    
    curl -LSso ~/.vim/bundle/my/colors/base16-parkjinwoo.vim \
    https://github.com/parkjinwoo/conf/raw/master/colors/base16-parkjinwoo.vim
    
    curl -LSso ~/.vim/bundle/my/syntax/python.vim \
    https://www.vim.org/scripts/download_script.php?src_id=21056
    
    curl -LSso ~/.vimrc https://github.com/parkjinwoo/conf/raw/master/vimrc

# git config

    git config --global user.name "${name}"
    git config --global user.email ${email}
    git config --global core.editor vim
    git config --global color.ui true
    git config --global alias.ll "log --graph --all --format=format:'%C(blue)%h%C(reset) %C(yellow)%d%C(reset) %C(green)%s%C(reset) %C(red)(%ar)%C(reset) %C(bold cyan)— %an%C(reset)' --abbrev-commit --date=relative"
