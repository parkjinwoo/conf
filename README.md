conf
====

## [zinit](https://github.com/zdharma-continuum/zinit)

```
sh -c "$(curl -fsSL https://git.io/zinit-install)"
```

## zshrc

```
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice blockf atpull'zinit creinstall -q .'; zinit light zsh-users/zsh-completions
zicompinit
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ll='ls -alF --color=auto'
alias grep='grep --color=auto'
```

## homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install wget
brew install mise
brew install jq
brew install fzf
```

## ghostty
```sh
brew install ghostty
curl -fLo ~/.config/ghostty/config --create-dirs https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/ghostty_config
```

## AstroNvim

```sh
## Requirements
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
brew install neovim
brew install tree-sitter-cli

## Optional Requirements
brew install ripgrep
brew install lazygit
brew install gdu
brew install bottom

## Installation
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
```

## vimrc

```
curl -LSso ~/.vimrc https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/vimrc
```

## [vim-plug](https://github.com/junegunn/vim-plug)

- vim
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
- neovim
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## git config

```
git config --global user.name "${name}"
git config --global user.email ${email}
git config --global core.editor vim
git config --global color.ui true
git config --global alias.ll "log --graph --abbrev-commit --all --decorate --format=format:'%C(bold blue)%h%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset) %C(green)%aD%C(reset) %C(cyan)(%ar)%C(reset)%C(yellow)%d%C(reset)'"
git config --global alias.lg "log --graph --abbrev-commit --all --decorate --format=format:'%C(bold blue)%h%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%n''         %C(green)%aD%C(reset) %C(cyan)(%ar)%C(reset)%C(yellow)%d%C(reset)'"
```
