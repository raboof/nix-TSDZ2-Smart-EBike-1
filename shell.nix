{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.callPackage ./default.nix {
      stm8-binutils = pkgs.callPackage ./stm8-binutils.nix {};
    })
  ];
}
