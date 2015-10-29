local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%}%s)%t%{$reset_color%}"
PROMPT='%{$fg[green]%}%n%{$fg[yellow]%}@%{$fg[magenta]%}%m%{$reset_color%} %{$fg[blue]%}${PWD/#$HOME/~} %{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[cyan]%} ${ret_status}
$ '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%})%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%})"
