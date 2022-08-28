{ stdenv
, fetchFromGitHub
, sdcc
, enableDebugging
, stm8-binutils
}:

stdenv.mkDerivation rec {
  pname = "TSDZ2-Smart-EBike-1";
  version = "20.1C.1-VLCD5-VLCD6-XH18";

  src = fetchFromGitHub {
    owner = "emmebrusa";
    repo = "TSDZ2-Smart-EBike-1";
    rev = "v${version}";
    hash = "sha256:1ixp9f8hj1g25kmw3q2ivb8jbzfz2i11x0al8hnrgyvvlri1sv9m";
  };

  patches = [
    # https://sourceforge.net/p/sdcc/bugs/2906/
    ./avoid-creating-debugging-symbols.patch
  ];

  nativeBuildInputs = [
    stm8-binutils
    (sdcc.overrideAttrs(old: {
      patches = [
        # https://sourceforge.net/p/sdcc/patches/397/
        # no longer needed since a variation of this patch made
        # it into sdcc 4.2.0 which is now in nixos-unstable
        #./sdcc-stm8-large-variable-names.patch
      ];
    }))
  ];

  makeFlags = [ "-C" "src/controller" "-f" "Makefile_linux" ];

  installTargets = [ "hex" ];
  postInstall = ''
    mkdir -p $out
    cp src/controller/main.ihx $out
  '';
}
