{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "jdk-mission-control";
  version = "9.1.1";

  src = pkgs.fetchurl {
    url = "https://github.com/adoptium/jmc-build/releases/download/${version}/org.openjdk.jmc-${version}-macosx.cocoa.aarch64.tar.gz";
    sha256 = "sha256-fWhbjrkgcYiJzeNLp7tACMkY61Zf1iSLaZ/jJA1MK+U=";
  };

  nativeBuildInputs = [ ];

  buildInputs = [ pkgs.jdk21 ];

  unpackPhase = ''
    tar xzvf $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    mv "JDK Mission Control.app" $out/Applications/

    # Patch zmc.ini to use Nix Java
    iniFile="$out/Applications/JDK Mission Control.app/Contents/Eclipse/jmc.ini"
    if [ -f "$iniFile" ]; then
      # Insert --vm line before -vmargs
      sed -i '/^-vmargs/i\-vm\n${pkgs.jdk21}/bin' "$iniFile"
    fi
  '';

  meta = with pkgs.lib; {
    description = "Eclipse Mission Control is a low-overhead profiling and diagnostics tools suite for the JVM.";
    homepage = "https://adoptium.net/jmc";
    platforms = platforms.darwin;
    maintainers = [ ];
    license = licenses.upl;
  };
}
