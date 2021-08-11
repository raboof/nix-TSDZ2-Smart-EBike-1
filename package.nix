{ pkgs ? import <nixpkgs> {} }:

{
  stm8-binutils = pkgs.callPackage ./stm8-binutils.nix {};
  bike = pkgs.callPackage ./default.nix {
    stm8-binutils = pkgs.callPackage ./stm8-binutils.nix {};
  };
}
