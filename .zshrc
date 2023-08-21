# shellcheck shell=sh

# zmodload zsh/zprof
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>"$logfile"

# setopt XTRACE

if type brew > /dev/null 2>&1
then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

alias gtfs="curl https://cdn.mbta.com/MBTA_GTFS.zip --output gtfs.zip"

eval "$(rtx activate zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# zprof
# unsetopt XTRACE
# exec 2>&3 3>&-
source ~/.config/op/plugins.sh
