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

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto --group-directories-first'
  alias ll='eza -alh --icons=auto --git --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto --git --group-directories-first'
  alias lt2='eza --tree --level=2 --icons=auto --git --group-directories-first'
  alias lt3='eza --tree --level=3 --icons=auto --git --group-directories-first'
elif command -v gls >/dev/null 2>&1; then
  alias ll='gls -alF --color=auto'
else
  alias ll='ls -alG'
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
  export ATUIN_NOBIND=1
  eval "$(atuin init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

if command -v ggrep >/dev/null 2>&1; then
  alias grep='ggrep --color=auto'
else
  alias grep='grep --color=auto'
fi
```

## homebrew

```zsh
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew bundle --file=- <<'BREWFILE'
# CLI 도구
brew "wget" # HTTP/FTP 다운로더
brew "coreutils" # GNU core 유틸 모음
brew "grep" # GNU grep
brew "jq" # JSON 파서/필터
brew "yq" # YAML/JSON 프로세서 (jq 스타일)
brew "parallel" # 작업 병렬 실행
brew "ripgrep" # 초고속 검색 (grep 대체)
brew "ripgrep-all" # PDF/문서 포함 통합 검색
brew "fd" # 직관적인 파일 찾기 (find 대체)
brew "fzf" # 퍼지 파인더
brew "eza" # 모던 ls (아이콘/Git 상태)
brew "bat" # 구문 강조 cat
brew "glow" # 터미널 Markdown 뷰어
brew "yazi" # 모던 터미널 파일 매니저
brew "zoxide" # 스마트 cd (디렉토리 학습)
brew "atuin" # 셸 히스토리 검색/동기화
brew "gh" # GitHub CLI
brew "lazygit" # Git TUI 클라이언트
brew "git-delta" # Git diff 구문 강조
brew "mise" # 개발 도구 버전 관리 (asdf 대체)
brew "uv" # 빠른 Python 패키지/가상환경 관리
brew "neovim" # 모던 Vim 계열 에디터
brew "tree-sitter-cli" # Tree-sitter 파서 생성 도구
brew "shellcheck" # 쉘 스크립트 정적 분석
brew "tmux" # 터미널 멀티플렉서 (macOS 기본 미포함 환경 대비)
brew "zellij" # 터미널 멀티플렉서 (tmux 대체)
brew "procs" # 프로세스 뷰어 (ps 대체)
brew "btop" # 시스템 모니터 (htop 대체)
brew "dust" # 디스크 사용량 시각화 (du 대체)
brew "bitwarden-cli" # 비밀번호 관리자 CLI

# GUI 앱
cask "google-chrome" # 크롬 브라우저
cask "firefox" # 파이어폭스 브라우저
cask "naver-whale" # 웨일 브라우저
cask "ghostty" # GPU 가속 터미널
cask "wezterm" # Lua 설정 가능한 GPU 가속 터미널
cask "visual-studio-code" # 코드 에디터
cask "zed" # 초고속 코드 에디터 (Rust 기반)
cask "rectangle" # 윈도우 창 관리 (단축키)
cask "bitwarden" # 비밀번호 관리자
cask "notion" # 노트/문서 협업 도구
cask "obsidian" # 로컬 우선 노트/지식관리 도구
BREWFILE
```

## ghostty
```sh
curl -fLo ~/.config/ghostty/config --create-dirs \
    https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/ghostty_config
```

## tmux

```sh
curl -fLo ~/.config/tmux/tmux.conf --create-dirs \
  https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/tmux.conf

curl -fLo ~/.config/tmux/scripts/statusbar.sh --create-dirs \
  https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/tmux_scripts_statusbar.sh

chmod +x ~/.config/tmux/scripts/statusbar.sh
```

## Nerd Fonts

https://www.nerdfonts.com/font-downloads

```sh
# 공식 형식: brew install --cask font-<FONT NAME>-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

# 전체 설치
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
```

## AstroNvim

필수인 `neovim`, `tree-sitter-cli`와 선택 도구인 `ripgrep`, `lazygit`은 Homebrew 목록에 포함되어 있습니다.

```sh
## Optional Requirements
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
curl -fLo ~/.vimrc https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/vimrc
```

## [vim-plug](https://github.com/junegunn/vim-plug)

- vim
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
