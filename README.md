conf
====

## [zinit](https://github.com/zdharma-continuum/zinit)

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

## zshrc

```sh
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

if command -v gls >/dev/null 2>&1; then
  alias ll='gls -alF --color=auto'
else
  alias ll='ls -alG'
fi
alias grep='grep --color=auto'
```

## homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# CLI 도구
# wget: HTTP/FTP 다운로더
# jq: JSON 파서/필터
# fzf: 퍼지 파인더
# zellij: 터미널 멀티플렉서 (tmux 대체)
# tmux: 터미널 멀티플렉서 (macOS 기본 미포함 환경 대비)
# mise: 개발 도구 버전 관리 (asdf 대체)
# gh: GitHub CLI
# lazygit: Git TUI 클라이언트
# git-delta: Git diff 구문 강조
# ripgrep: 초고속 검색 (grep 대체)
# fd: 직관적인 파일 찾기 (find 대체)
# eza: 모던 ls (아이콘/Git 상태)
# bat: 구문 강조 cat
# zoxide: 스마트 cd (디렉토리 학습)
# btop: 시스템 모니터 (htop 대체)
# dust: 디스크 사용량 시각화 (du 대체)
# procs: 프로세스 뷰어 (ps 대체)
# parallel: 작업 병렬 실행
# yq: YAML/JSON 프로세서 (jq 스타일)
# uv: 빠른 Python 패키지/가상환경 관리
# shellcheck: 쉘 스크립트 정적 분석
# bitwarden-cli: 비밀번호 관리자 CLI
brew install \
  wget \
  jq \
  fzf \
  zellij \
  tmux \
  mise \
  gh \
  lazygit \
  git-delta \
  ripgrep \
  fd \
  eza \
  bat \
  zoxide \
  btop \
  dust \
  procs \
  parallel \
  yq \
  uv \
  shellcheck \
  bitwarden-cli

# GUI 앱
# google-chrome: 크롬 브라우저
# firefox: 파이어폭스 브라우저
# naver-whale: 웨일 브라우저
# rectangle: 윈도우 창 관리 (단축키)
# visual-studio-code: 코드 에디터
# zed: 초고속 코드 에디터 (Rust 기반)
# bitwarden: 비밀번호 관리자
# notion: 노트/문서 협업 도구
# obsidian: 로컬 우선 노트/지식관리 도구
# ghostty: GPU 가속 터미널
# wezterm: Lua 설정 가능한 GPU 가속 터미널
brew install --cask \
  google-chrome \
  firefox \
  naver-whale \
  rectangle \
  visual-studio-code \
  zed \
  bitwarden \
  notion \
  obsidian \
  ghostty \
  wezterm
```

## ghostty
```sh
curl -fLo ~/.config/ghostty/config --create-dirs \
    https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/ghostty_config
```

## zellij

```sh
curl -fLo ~/.config/zellij/layouts/agent.kdl --create-dirs \
    https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/zellij-agent-layout.kdl

zellij -l agent
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

```sh
curl -LSso ~/.vimrc https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/vimrc
```

## [vim-plug](https://github.com/junegunn/vim-plug)

- vim
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## tmux

```sh
curl -fLo ~/.config/tmux/tmux.conf --create-dirs \
  https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/tmux.conf

curl -fLo ~/.config/tmux/scripts/statusbar.sh --create-dirs \
  https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/tmux_scripts_statusbar.sh

curl -fLo ~/.config/tmux/layouts/agent.conf --create-dirs \
  https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/tmux_layouts_agent.conf

chmod +x ~/.config/tmux/scripts/statusbar.sh

# 레이아웃 실행
tmux new-session \; source-file ~/.config/tmux/layouts/agent.conf
```

## git config

```sh
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
# ~/.local/bin이 PATH에 없다면:
# export PATH="$HOME/.local/bin:$PATH"
git config --global alias.gk '!git-gk'
```
