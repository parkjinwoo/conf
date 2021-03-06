export TERM="xterm-color"
export CLICOLOR=1
export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"

# export PS1="\[\033[00;36m\]\u\[\033[00;33m\]@\[\033[00;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
# export PS1="$(tput sgr0)$(tput setaf 6)\u$(tput setaf 3)@$(tput setaf 5)\h $(tput bold;tput setaf 4)\W\$(vcprompt -f "$(tput sgr0):$(tput setaf 3)%b$(tput setaf 1)%m$(tput setaf 2)%a$(tput setaf 5)%u")$(tput sgr0)\n\$ "

alias ll='ls -alF'
alias grep='grep --color=auto'
# alias mvim='/Applications/MacVim/mvim -v'

# find /usr/local -type f -name "git-completion.bash" -print
# source /usr/local/Cellar/git/x.x.x/etc/bash_completion.d/git-completion.bash
