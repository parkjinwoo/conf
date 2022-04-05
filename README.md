conf
====

# vimrc
    
    curl -LSso ~/.vimrc https://github.com/parkjinwoo/conf/raw/master/vimrc
    
# zshrc

```
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice blockf atpull'zinit creinstall -q .'; zinit light zsh-users/zsh-completions
zicompinit
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

alias ll='ls -alF --color=auto'
```

# git config

```
git config --global user.name "${name}"
git config --global user.email ${email}
git config --global core.editor vim
git config --global color.ui true
git config --global alias.ll "log --graph --abbrev-commit --all --decorate --format=format:'%C(bold blue)%h%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset) %C(green)%aD%C(reset) %C(cyan)(%ar)%C(reset)%C(yellow)%d%C(reset)'"
git config --global alias.lg "log --graph --abbrev-commit --all --decorate --format=format:'%C(bold blue)%h%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n''         %C(green)%aD%C(reset) %C(cyan)(%ar)%C(reset)%C(yellow)%d%C(reset)'"
```
