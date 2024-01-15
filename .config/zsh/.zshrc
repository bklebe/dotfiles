# shellcheck shell=sh

# zmodload zsh/zprof
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# setopt XTRACE
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>"$logfile"

eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

if type brew >/dev/null 2>&1; then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION" 
fi

source <(jj util completion --zsh)

. "$(pack completion --shell zsh)"

alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

alias gtfs="curl https://cdn.mbta.com/MBTA_GTFS.zip --output gtfs.zip"

unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

source $HOME/.config/op/plugins.sh

alias make="op run -- make"

alias terraform="op run -- terraform"

function tfp() {
  # Capture the output of the terraform plan command with the supplied flags
  local output
  output=$(terraform plan -no-color "$@" | awk '/Terraform (planned the following actions, but then encountered a problem:|will perform the following actions:)/, /Plan:/ { print }')

  # Print the output to the terminal
  echo "$output"

  # Copy the output to macOS clipboard
  echo "$output" | pbcopy
  echo "The plan has been copied to the clipboard."
}

izsh() {
  local old_path=$PATH
  export PATH=/usr/local/bin:$PATH
  arch -x86_64 zsh
  export PATH=$old_path
}

wine-gptk() {
  WINEESYNC=1 WINEPREFIX=~/game-prefix $(/usr/local/bin/brew --prefix game-porting-toolkit)/bin/wine64 "$@"
}

# eval "$(devbox global shellenv)"

eval "$(starship init zsh)"

# zprof
# unsetopt XTRACE
# exec 2>&3 3>&-
