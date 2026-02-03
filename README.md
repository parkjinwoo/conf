conf
====

## [zinit](https://github.com/zdharma-continuum/zinit)

```sh
sh -c "$(curl -fsSL https://git.io/zinit-install)"
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

alias ll='ls -alF --color=auto'
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
# bitwarden-cli: 비밀번호 관리자 CLI
brew install \
  wget \
  jq \
  fzf \
  zellij \
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
brew install --cask \
  google-chrome \
  firefox \
  naver-whale \
  rectangle \
  visual-studio-code \
  zed \
  bitwarden \
  notion
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

```sh
curl -LSso ~/.vimrc https://raw.githubusercontent.com/parkjinwoo/conf/refs/heads/main/vimrc
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
git config --global alias.gk '!git-gk'
```

## Podman

```sh
# Podman 컨테이너 도구
# podman: Docker 대체 컨테이너 엔진 (데몬리스, 루트리스)
# podman-compose: docker-compose 대체
# lazydocker: 컨테이너 관리 TUI
brew install \
  podman \
  podman-compose \
  lazydocker

# podman machine
podman machine init    # 기본 설정으로 초기화
podman machine start   # 시작
podman machine init --cpus=4 --memory=4096 --disk-size=100 # 커스텀 리소스로 초기화 (cpus: 코어 수, memory: MB, disk-size: GB)
podman machine init -v $HOME:$HOME   # 볼륨 마운트가 필요한 경우 (init 시점에 설정)
podman machine init -v $HOME:$HOME:z # 마운트 볼륨 권한 문제 시

podman machine set --rootful # rootful (재시작 필요)
podman machine ssh sudo sysctl -w net.ipv4.ip_unprivileged_port_start=0 # VM 내부에서 unprivileged port 설정 변경
podman run -it --rm --cap-add net_bind_service my/image # 또는 컨테이너 실행 시 옵션 추가 (non-root 사용자인 경우)

# 애플 실리콘에서 arm64 또는 multi-arch 이미지는 네이티브로 실행됨. amd64 전용 이미지 실행이 필요한 경우.
podman machine ssh sudo rpm-ostree install qemu-user-static
podman machine ssh sudo systemctl reboot

# etc
podman machine info
podman machine ls
podman machine rm
podman machine ssh
podman system prune
podman run -it ubuntu bash
podman ps
podman images
podman login registry.example.com # Private Registry 로그인

# Podman 소켓 활성화 (Linux) / macOS에서는 podman machine 시작 시 자동 활성화
systemctl --user start podman.socket

# .zshrc에 추가
export DOCKER_HOST="unix://$HOME/.local/share/containers/podman/machine/podman.sock"
alias docker=podman

# Multi-arch 이미지 빌드
podman build --platform linux/arm64,linux/amd64 --format docker -t my-image .
```

# podman compose

```sh
podman-compose up -d
```

```yaml
# 호스트 접근 (컨테이너 → 호스트) docker-compose.yml 예시 Docker의 host.docker.internal 대신 host.containers.internal을 사용
services:
  web:
    image: nginx
    extra_hosts:
      - "host.docker.internal:host-gateway"  # Docker 호환
```

# 또는 컨테이너 내부에서

```sh
curl http://host.containers.internal:8080
```
