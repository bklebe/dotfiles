# shellcheck shell=sh

XDG_RUNTIME_DIR="$HOME"/Library/Caches/TemporaryItems
mkdir -p "$XDG_RUNTIME_DIR"
export XDG_RUNTIME_DIR

export DIRENV_LOG_FORMAT=

export HISTFILE="$XDG_STATE_HOME"/zsh/history

export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal

export GHCUP_USE_XDG_DIRS=true

GPG_TTY=$(tty)
export GPG_TTY

export GOPATH="$XDG_DATA_HOME"/go

export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube

export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export OPAMROOT="$XDG_DATA_HOME"/opam

export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc

export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph

export STACK_ROOT="$XDG_DATA_HOME"/stack

export WINEPREFIX="$XDG_DATA_HOME"/wine
