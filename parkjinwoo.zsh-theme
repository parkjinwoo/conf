local ret_status="%{$bg[yellow]%}%(?:%{$fg_bold[black]%}:%{$fg_bold[red]%}%s)%D{%Y-%m-%d %H:%M:%S}%{$reset_color%}"

PROMPT='%{$fg[magenta]%}%n%{$fg[yellow]%}@%{$fg[green]%}%m%{$reset_color%}%{$fg[silver]%}:%{$fg[blue]%}${PWD/#$HOME/~}$(git_prompt_info)${ret_status}
$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}%{$bg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}%{$fg[white]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}%{$fg[yellow]%}✘%{$reset_color%}"

# ZSH_THEME_GIT_PROMPT_ADDED="%{$reset_color%}%{$fg[green]%}✚%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$reset_color%}%{$fg[white]%}●%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$reset_color%}%{$fg[red]%}✖%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$reset_color%}%{$fg[white]%}%{bg[red]%}☒%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$reset_color%}%{$fg[cyan]%}➜%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$reset_color%}%{$fg[magenta]%}⎇%{$reset_color%}"

# ZSH_THEME_GIT_PROMPT_AHEAD="%{$reset_color%}%{$fg[yellow]%}↑%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_BEHIND="%{$reset_color%}%{$fg[yellow]%}↓{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIVERGED="%{$reset_color%}%{$fg[yellow]%}↕%{$reset_color%}"
