# shellcheck shell=sh

. "$XDG_DATA_HOME"/cargo/env

export EDITOR="emacsclient --alternate-editor='emacs' --create-frame"

alias emacs="$EDITOR --no-wait"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
prefix=$(brew --prefix)
alias ibrew="/usr/local/bin/brew"

export XDG_CONFIG_HOME="$HOME/.config"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export PATH="\
$HOME/bin:\
$HOME/.local/bin:\
$prefix/opt/grep/libexec/gnubin:\
$prefix/opt/python@3.11/libexec/bin:\
$XDG_CONFIG_HOME/emacs/bin:\
$HOME/Library/Application Support/JetBrains/Toolbox/scripts:\
/Applications/gg.app/Contents/MacOS/:\
$PATH"

export AWS_ACCESS_KEY_ID="op://Private/tv6emkuxmewujdu7w5i4lfms7u/access key id"
export AWS_SECRET_ACCESS_KEY="op://Private/tv6emkuxmewujdu7w5i4lfms7u/secret access key"

export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I$prefix/opt/unixodbc/include"
export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L$prefix/opt/unixodbc/lib"
export KERL_CONFIGURE_OPTIONS="--with-odbc=$prefix/opt/unixodbc --with-ssl=$prefix/opt/openssl@3"
export KERL_BUILD_DOCS=yes
export KERL_DOC_TARGETS="man html pdf chunks"

# Added by OrbStack: command-line tools and integration
# source ~/.orbstack/shell/init.zsh 2>/dev/null || :

HB_CNF_HANDLER="$prefix/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER"
fi
