# shellcheck shell=sh

# shellcheck source=~/.cargo/env
. "$HOME/.cargo/env"

export EDITOR="emacsclient --alternate-editor='emacs' --create-frame"

alias emacs="$EDITOR --no-wait"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
prefix=$(brew --prefix)
alias ibrew="/usr/local/bin/brew"

export XDG_CONFIG_HOME="$HOME/.config"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export PATH="\
$HOME/.local/share/rtx/shims:\
$HOME/bin:\
$prefix/opt/grep/libexec/gnubin:\
$prefix/opt/python@3.11/libexec/bin:\
$XDG_CONFIG_HOME/emacs/bin:\
$HOME/Library/Application Support/JetBrains/Toolbox/scripts:\
$PATH"

export AWS_ACCESS_KEY_ID=op://Development/AWS/credentials/access_key_id
export AWS_SECRET_ACCESS_KEY=op://Development/AWS/credentials/secret_access_key

export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I$prefix/opt/unixodbc/include"
export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L$prefix/opt/unixodbc/lib"
export KERL_CONFIGURE_OPTIONS="--with-odbc=$prefix/opt/unixodbc --with-ssl=$prefix/opt/openssl@3"
export KERL_BUILD_DOCS=yes
export KERL_DOC_TARGETS="man html pdf chunks"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

HB_CNF_HANDLER="$prefix/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER"
fi
