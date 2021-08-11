{ stdenv
, fetchzip
, fetchurl
, symlinkJoin
, binutils-unwrapped
, runCommand
, texinfo
}:

let
  binutils-src = fetchurl {
    url = "mirror://gnu/binutils/binutils-2.30.tar.xz";
    hash = "sha256-bka4rq4vcno28L2VBeQFdopyIY8XlvDQl1fUUgmHGuY=";
  };
  gdb-src = fetchurl {
    url = "mirror://gnu/gdb/gdb-8.1.tar.xz";
    hash = "sha256-r2GgJjhY5pxdzlHqsmZi/z0q2apo2pWD6BQ7VCa+SzQ=";
  };
  combined-binutils-gdb-src =
    runCommand "combined-binutils-gdb" {} ''
      mkdir -p $out
      tar -xvf ${gdb-src}      --strip-components 1 --directory $out
      tar -xvf ${binutils-src} --strip-components 1 --directory $out
    '';
  stm8-binutils-gdb-sources = fetchzip { 
    url = "mirror://sourceforge/stm8-binutils-gdb/stm8-binutils-gdb-sources-2021-07-18.tar.gz";
    hash = "sha256-p0KTL43Izm4UfyyjXT0nIpIjRlGbg0jFtlGyrS7V8lo=";
  };
  stm8-binutils-gdb-patches =
    let 
      root = "${stm8-binutils-gdb-sources}/binutils_patches";
      names = builtins.attrNames (builtins.readDir root);
    in map (name: root + "/${name}") names;

in
stdenv.mkDerivation {
  name = "stm8-binutils";
  version = "2021-07-18";

  src = combined-binutils-gdb-src;

  nativeBuildInputs = [ texinfo ];

  patchFlags = [ "-N" "-p1" ];
  patches = 
    stm8-binutils-gdb-patches ++ [
      ./gold-fix-imports.patch
    ];

  configureFlags = [ "--target=stm8-none-elf32" "--program-prefix=stm8-" ];
  makeFlags = [ "all-binutils" ];

  installTargets = [ "install-binutils" ];
}
