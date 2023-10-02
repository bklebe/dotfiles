# shellcheck shell=sh

# zmodload zsh/zprof
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>"$logfile"

# setopt XTRACE

if type brew >/dev/null 2>&1; then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

alias gtfs="curl https://cdn.mbta.com/MBTA_GTFS.zip --output gtfs.zip"

eval "$(rtx activate zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

alias gmake="op run -- gmake"

alias terraform="op run -- terraform"

# zprof
# unsetopt XTRACE
# exec 2>&3 3>&-
source ~/.config/op/plugins.sh

function tfp() {
  # Capture the output of the terraform plan command with the supplied flags
  local output
  output=$(terraform plan -no-color "$@" | awk '/Terraform will perform the following actions:/, /Plan:/ { print }')

  # Print the output to the terminal
  echo "$output"

  # Copy the output to macOS clipboard
  echo "$output" | pbcopy
  echo "The plan has been copied to the clipboard."
}
