# shellcheck shell=sh

# shellcheck source=~/.cargo/env
. "$HOME/.cargo/env"

emacs="emacsclient --alternate-editor='open -a Emacs.app' --create-frame --no-wait"

alias emacs=$emacs

export EDITOR=$emacs

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
prefix=$(brew --prefix)

export XDG_CONFIG_HOME="$HOME/.config"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export PATH="$HOME/.local/share/rtx/shims:$HOME/bin:\
$prefix/opt/grep/libexec/gnubin:\
$prefix/opt/python@3.11/libexec/bin:\
$XDG_CONFIG_HOME/emacs/bin:\
$PATH:\
$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

export AWS_ACCESS_KEY_ID=op://Development/AWS/credentials/access_key_id
export AWS_SECRET_ACCESS_KEY=op://Development/AWS/credentials/secret_access_key

export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I$prefix/opt/unixodbc/include"
export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L$prefix/opt/unixodbc/lib"
export KERL_CONFIGURE_OPTIONS="--with-odbc=$prefix/opt/unixodbc --with-ssl=$prefix/opt/openssl@3"
export KERL_BUILD_DOCS=yes
export KERL_DOC_TARGETS="man html pdf chunks"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
