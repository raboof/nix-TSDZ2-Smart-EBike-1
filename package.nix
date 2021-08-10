{ pkgs ? import <nixpkgs> {} }:

{
  bike = pkgs.callPackage ./default.nix {};
}
