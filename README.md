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
brew install zellij
brew install lazygit
brew install git-delta
```

## ghostty
```sh
brew install ghostty
curl -fLo ~/.config/ghostty/config --create-dirs \
    https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/ghostty_config
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

## `~/.config/nvim/lua/community.lua`

```lua
{ import = "astrocommunity.color.transparent-nvim" },
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
# 기본 설정
git config --global user.name "My Name"
git config --global user.email "my@email.com"
git config --global core.editor nvim
git config --global init.defaultBranch main

# git-delta 사용 시 (brew install git-delta)
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global merge.conflictStyle zdiff3

# 편의 설정
git config --global push.autoSetupRemote true
git config --global fetch.prune true
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global rerere.enabled true
git config --global diff.colorMoved default
git config --global branch.sort -committerdate

# git kit
curl -fLo ~/.local/bin/git-gk --create-dirs \
    https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/git-gk.sh
chmod +x ~/.local/bin/git-gk
git config --global alias.gk '!git-gk'
```
