{
  config,
  pkgs,
  user,
  userPackages,
  extraNushellConfig,
  lib,
  ...
}:
let
  nu-scripts = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "nu_scripts";
    rev = "ba9a4c1caca935b98ad05caad50687be8c2b21cd";
    sha256 = "sha256-p6jRvJ9r3+HEgAZxjxSAC4hXO7MQ+PlPcKZU9Q9vNJ0=";
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user;
  home.homeDirectory = "/Users/${user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.overlays = [
    (final: prev: {
      protoc-gen-grpc-java = prev.protoc-gen-grpc-java.overrideAttrs (
        oldAttrs:
        let
          baseInputs = oldAttrs.nativeBuildInputs or [ ];
        in
        {
          nativeBuildInputs =
            if prev.stdenv.isDarwin then
              builtins.filter (dep: dep != prev.autoPatchelfHook) baseInputs
            else
              baseInputs;
        }
      );
    })
  ];
  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
    ];
  home.packages = userPackages ++ [
    pkgs.nixfmt-tree
    pkgs.nixd
    pkgs.nil
    pkgs.scc
    pkgs.rustup
    pkgs.protoc-gen-grpc-java
    pkgs._1password-cli
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".zshenv".text = ''
      export ZDOTDIR=${config.xdg.configHome}/zsh
      . "$ZDOTDIR"/.zshenv
    '';
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile = {
    "doom".source = xdg-config/doom;
    "fish/config.fish".source = xdg-config/fish/config.fish;
    "ghostty/config".text = ''
      macos-option-as-alt = left
      keybind = alt+left=esc:b
      keybind = alt+right=esc:f
      font-family = "PragmataPro Mono"
      font-size = 14
      font-feature = -calt
      font-feature = -liga
      font-feature = -dlig
      scrollback-limit = 1_000_000_000
      auto-update = download
      auto-update-channel = tip
      env = XDG_CONFIG_HOME=${config.xdg.configHome}
      env = XDG_DATA_HOME=${config.xdg.dataHome}
      env = XDG_CACHE_HOME=${config.xdg.cacheHome}
      env = XDG_STATE_HOME=${config.xdg.stateHome}
      command = ${pkgs.nushell}/bin/nu
      keybind = shift+enter=text:\n
    '';
    "mise".source = xdg-config/mise;
    "nushell/nix.nu".source = xdg-config/nushell/nix.nu;
    "nushell/mise.nu".source = xdg-config/nushell/mise.nu;
    "powershell".source = xdg-config/powershell;
    "python".source = xdg-config/python;
    "zsh" = {
      source = xdg-config/zsh;
      recursive = true;
    };
  };
  xdg.enable = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ada/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nushell = {
    enable = true;
    configFile.source = xdg-config/nushell/config.nu;
    extraConfig =
      extraNushellConfig
      + "\n"
      + ''
        source ${nu-scripts}/custom-completions/aws/aws-completions.nu
        source ${nu-scripts}/custom-completions/curl/curl-completions.nu
        source ${nu-scripts}/custom-completions/docker/docker-completions.nu
        source ${nu-scripts}/custom-completions/gh/gh-completions.nu
        source ${nu-scripts}/custom-completions/git/git-completions.nu
        source ${nu-scripts}/custom-completions/gradlew/gradlew-completions.nu
        source ${nu-scripts}/custom-completions/less/less-completions.nu
        source ${nu-scripts}/custom-completions/make/make-completions.nu
        source ${nu-scripts}/custom-completions/man/man-completions.nu
        source ${nu-scripts}/custom-completions/mix/mix-completions.nu
        source ${nu-scripts}/custom-completions/mvn/mvn-completions.nu
        source ${nu-scripts}/custom-completions/nix/nix-completions.nu
        source ${nu-scripts}/custom-completions/npm/npm-completions.nu
        source ${nu-scripts}/custom-completions/op/op-completions.nu
        source ${nu-scripts}/custom-completions/rg/rg-completions.nu
        source ${nu-scripts}/custom-completions/rustup/rustup-completions.nu
        source ${nu-scripts}/custom-completions/ssh/ssh-completions.nu
        source ${nu-scripts}/custom-completions/tar/tar-completions.nu
        source ${nu-scripts}/custom-completions/uv/uv-completions.nu
        source ${nu-scripts}/custom-completions/vscode/vscode-completions.nu
        source ${nu-scripts}/custom-completions/zellij/zellij-completions.nu
      '';
  };

  programs.mise = {
    enable = true;
    enableNushellIntegration = false;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.jujutsu = {
    enable = true;
  };
  programs.ripgrep = {
    enable = true;
  };
  programs.awscli = {
    enable = true;
  };
}
