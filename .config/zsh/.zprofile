# shellcheck shell=sh

. "$XDG_DATA_HOME"/cargo/env

export EDITOR="code --new-window --wait"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
prefix=$(brew --prefix)
alias ibrew="/usr/local/bin/brew"

export XDG_CONFIG_HOME="$HOME/.config"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export PATH="\
$HOME/bin:\
$HOME/.local/bin:\
$prefix/opt/libpq/bin:\
$prefix/opt/grep/libexec/gnubin:\
$prefix/opt/python@3.11/libexec/bin:\
$HOME/Library/Application Support/Coursier/bin:\
$XDG_CONFIG_HOME/emacs/bin:\
$HOME/Library/Application Support/JetBrains/Toolbox/scripts:\
/Applications/gg.app/Contents/MacOS/:\
$PATH"

if [ -f "$ZDOTDIR"/.zprofile-local ]; then
    . "$ZDOTDIR"/.zprofile-local
fi

export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I$prefix/opt/unixodbc/include"
export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L$prefix/opt/unixodbc/lib"
export KERL_CONFIGURE_OPTIONS="--with-odbc=$prefix/opt/unixodbc --with-ssl=$prefix/opt/openssl@3"
export KERL_BUILD_DOCS=yes
export KERL_DOC_TARGETS="html chunks"

HB_CNF_HANDLER="$prefix/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
    . "$HB_CNF_HANDLER"
fi

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
