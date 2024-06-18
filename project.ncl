let inputs = import "./nickel.lock.ncl" in
let organist = inputs.organist in

{
  shells = organist.shells.Bash,

  shells.build = {
    packages = {},
  },

  shells.dev = {
    packages.hello = organist.import_nix "nixpkgs#hello",
    packages.awscli2 = organist.import_nix "nixpkgs#awscli2",
    packages.chezmoi = organist.import_nix "nixpkgs#chezmoi",
    packages.colima = organist.import_nix "nixpkgs#colima",
    packages.direnv = organist.import_nix "nixpkgs#direnv",
    packages.docker = organist.import_nix "nixpkgs#docker",
    packages.docker-buildx = organist.import_nix "nixpkgs#docker-buildx",
    packages.docker-compose = organist.import_nix "nixpkgs#docker-compose",
    packages.gh = organist.import_nix "nixpkgs#gh",
    packages.git = organist.import_nix "nixpkgs#git",
    packages.graphviz = organist.import_nix "nixpkgs#graphviz",
    packages.jq = organist.import_nix "nixpkgs#jq",
    packages.jujutsu = organist.import_nix "nixpkgs#jujutsu",
    packages.mise = organist.import_nix "nixpkgs#mise",
    packages.mosquitto = organist.import_nix "nixpkgs#mosquitto",
    packages.nixfmt-rfc-style = organist.import_nix "nixpkgs#nixfmt-rfc-style",
    packages.pandoc = organist.import_nix "nixpkgs#pandoc",
    packages.protobuf = organist.import_nix "nixpkgs#protobuf",
    packages.ripgrep = organist.import_nix "nixpkgs#ripgrep",
    packages.rustup = organist.import_nix "nixpkgs#rustup",
    packages.scc = organist.import_nix "nixpkgs#scc",
    packages.shfmt = organist.import_nix "nixpkgs#shfmt",
  },
}
  | organist.OrganistExpression
