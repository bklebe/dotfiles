{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "azul-mission-control";
  version = "9.1.1.35";

  src = pkgs.fetchurl {
    url = "https://cdn.azul.com/zmc/bin/zmc${version}-ca-macos_aarch64.tar.gz";
    sha256 = "sha256-hhBIbmXRh6+30VTRlQ8s5mfbwvbV62pJYjaJma04Klo=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  buildInputs = [ pkgs.jdk21 ];

  unpackPhase = ''
    tar -xzf $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    mv "zmc$version-ca-macos_aarch64/Azul Mission Control.app" $out/Applications/

    # Patch zmc.ini to use Nix Java
    iniFile="$out/Applications/Azul Mission Control.app/Contents/Eclipse/zmc.ini"
    if [ -f "$iniFile" ]; then
      # Insert --vm line before -vmargs
      sed -i '/^-vmargs/i\-vm\n${pkgs.jdk21}/bin' "$iniFile"
    fi
  '';

  meta = with pkgs.lib; {
    description = "Azul Zulu Mission Control - Java application monitoring tool";
    homepage = "https://www.azul.com/products/components/azul-mission-control/";
    platforms = platforms.darwin;
    maintainers = [ ];
    license = licenses.upl;
  };
}
