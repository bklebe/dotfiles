# shellcheck shell=sh

# zmodload zsh/zprof
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# setopt XTRACE
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>"$logfile"

eval "$(mise activate zsh)"

zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

if type brew >/dev/null 2>&1; then
  FPATH="$HOME/.config/zsh/functions/:$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"

  autoload bashcompinit && bashcompinit
  autoload -Uz compinit && compinit
  complete -C "$HOMEBREW_PREFIX/bin/aws_completer" aws
  compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
  . <(jj util completion zsh)
fi


# . "$(pack completion --shell zsh)"

alias svn='svn --config-dir $XDG_CONFIG_HOME/subversion'

alias gtfs="curl https://cdn.mbta.com/MBTA_GTFS.zip --output gtfs.zip"

unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

alias wget='wget --hsts-file=$XDG_DATA_HOME/wget-hsts'

tfp() {
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

wine_gptk() {
  WINEESYNC=1 WINEPREFIX=~/game-prefix "$(/usr/local/bin/brew --prefix game-porting-toolkit)"/bin/wine64 "$@"
}

zipdiff() { diff -W200 -y <(unzip -vql "$1" | sort -k8) <(unzip -vql "$2" | sort -k8); }
zipcdiff() {
  A='{printf("%8sB %s %s\n",$1,$7,$8)}'
  diff <(unzip -vqql "$1" | awk "$A" | sort -k3) <(unzip -vqql "$2" | awk "$A" | sort -k3)
}

uninstall_nix_darwin() {
  nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
  sudo mv /etc/bashrc.before-nix-darwin /etc/bashrc
  sudo mv /etc/nix/nix.conf.before-nix-darwin /etc/nix/nix.conf
  sudo mv /etc/ssl/certs/ca-certificates.crt.before-nix-darwin /etc/ssl/certs/ca-certificates.crt
}

# eval "$(devbox global shellenv)"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

bindkey "\e[1;3D" backward-word     # ⌥←
bindkey "\e[1;3C" forward-word      # ⌥→
bindkey "^[[1;9D" beginning-of-line # ⌘+←
bindkey "^[[1;9C" end-of-line       # ⌘+→


# zprof
# unsetopt XTRACE
# exec 2>&3 3>&-
