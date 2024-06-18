{ pkgs, lib, config, inputs, ... }:

{
  cachix.enable = false;
  # https://devenv.sh/basics/
  # env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.awscli2
    pkgs.chezmoi
    pkgs.colima
    pkgs.docker
    pkgs.docker-buildx
    pkgs.docker-compose
    pkgs.gh
    pkgs.git
    pkgs.graphviz
    pkgs.jq
    pkgs.mosquitto
    pkgs.nixfmt-rfc-style
    pkgs.pandoc
    pkgs.protobuf
    pkgs.ripgrep
    pkgs.rustup
    pkgs.scc
    pkgs.shfmt
  ];

  # https://devenv.sh/scripts/
  # scripts.hello.exec = "echo hello from $GREET";

  # enterShell = ''
  #   hello
  #   git --version
  # '';

  # https://devenv.sh/tests/
  # enterTest = ''
  #   echo "Running tests"
  #   git --version | grep "2.42.0"
  # '';

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/languages/
  # languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
