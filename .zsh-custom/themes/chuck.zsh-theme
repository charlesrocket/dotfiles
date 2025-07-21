PROMPT='%{$fg_bold[red]%}  %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

RPROMPT='$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[white]%} 󰧇"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[white]%} 󰦿"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} "
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[white]%} 󰆓"
