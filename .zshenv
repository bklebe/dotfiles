# shellcheck shell=sh

# shellcheck source=~/.cargo/env
. "$HOME/.cargo/env"

export EDITOR="code --wait"

# Set PATH, MANPATH, etc., for Homebrew.
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}";
export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
export HELPDIR="$HOMEBREW_PREFIX/share/zsh/help";

export PATH="$HOME/bin:\
$HOME/.docker/bin:\
$HOMEBREW_PREFIX/opt/python@3.11/libexec/bin:\
$PATH:\
$HOME/Library/Application Support/JetBrains/Toolbox/scripts"


export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I$HOMEBREW_PREFIX/opt/unixodbc/include"
export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L$HOMEBREW_PREFIX/opt/unixodbc/lib"
export KERL_CONFIGURE_OPTIONS="--with-odbc=$HOMEBREW_PREFIX/opt/unixodbc"
export KERL_BUILD_DOCS=yes
export KERL_DOC_TARGETS="man html pdf chunks"
