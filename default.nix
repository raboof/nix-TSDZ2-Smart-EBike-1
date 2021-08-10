{ stdenv
, fetchFromGitHub
, sdcc
, enableDebugging
}:

stdenv.mkDerivation rec {
  pname = "TSDZ2-Smart-EBike-1";
  version = "20.1C.1-VLCD5-VLCD6-XH18";

  #src = /home/aengelen/dev/TSDZ2-Smart-EBike-1;
  src = fetchFromGitHub {
    owner = "emmebrusa";
    repo = "TSDZ2-Smart-EBike-1";
    rev = "v${version}";
    hash = "sha256:1ixp9f8hj1g25kmw3q2ivb8jbzfz2i11x0al8hnrgyvvlri1sv9m";
  };

  nativeBuildInputs = [
    (sdcc.overrideAttrs(old: {
      patches = [
        # https://sourceforge.net/p/sdcc/patches/397/
        ./sdcc-stm8-large-variable-names.patch
      ];
    }))
  ];
  makeFlags = [ "-C" "src/controller" "-f" "Makefile_linux" ];
}
