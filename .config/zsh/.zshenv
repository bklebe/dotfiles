# shellcheck shell=sh

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_RUNTIME_DIR="$HOME"/Library/Caches/TemporaryItems

export HISTFILE="$XDG_STATE_HOME"/zsh/history

export ANDROID_HOME="$XDG_DATA_HOME"/android

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config

export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal

export CARGO_HOME="$XDG_DATA_HOME"/cargo

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export GHCUP_USE_XDG_DIRS=true

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
GPG_TTY=$(tty)
export GPG_TTY

export GOPATH="$XDG_DATA_HOME"/go

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube

export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo

export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

export OPAMROOT="$XDG_DATA_HOME"/opam

export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc

export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph

export STACK_ROOT="$XDG_DATA_HOME"/stack

export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant

export WINEPREFIX="$XDG_DATA_HOME"/wine
