{
  description = "Home Manager configuration of ada";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      mac-app-util,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."ada" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ mac-app-util.homeManagerModules.default ./home.nix ];
        extraSpecialArgs = {
          user = "ada";
          userPackages = [ ];
          extraNushellConfig = "";
        };
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      homeConfigurations."beatrix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ mac-app-util.homeManagerModules.default ./home.nix ];
        extraSpecialArgs = {
          user = "beatrix";
          userPackages = [
            pkgs.coursier
            pkgs.protobuf
            (pkgs.protoc-gen-grpc-java.overrideAttrs (
              oldAttrs:
              let
                baseInputs = oldAttrs.nativeBuildInputs;
              in
              {
                nativeBuildInputs =
                  if pkgs.stdenv.isDarwin then
                    builtins.filter (dep: dep != pkgs.autoPatchelfHook) baseInputs
                  else
                    baseInputs;
              }
            ))
          ];
          extraNushellConfig = "path add '~/Library/Application Support/Coursier/bin'";
        };
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
