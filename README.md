# nix-TSDZ2-Smart-EBike-1

This repo contains a Nix derivation to build the ebike firmware from
https://github.com/emmebrusa/TSDZ2-Smart-EBike-1

## About Nix

If you're unfamiliar with [Nix](https://nixos.org), it is a build tool on Linux
that tries to avoid "system-wide" dependencies, and instead lets you define
your dependencies per build. This makes it easy to define variations on
dependencies, like 'sdcc from the standard package collection (sdcc), except
with a patch applied'.

It is possible to use Nix on most Linux distributions, though there it will
likely take up a lot of disk space. When you go all-in on NixOS, you can share
the 'nix store' between your builds and your system.

## Status

Seems to be working, but haven't tested the resulting executable yet.

No debugging symbols because of a relocation issue
(https://github.com/raboof/nix-TSDZ2-Smart-EBike-1/issues/5)

Perhaps we should upstream the packaging of the stm8-binutils into nixpkgs?
(https://github.com/raboof/nix-TSDZ2-Smart-EBike-1/issues/4)

## Usage

`default.nix` contains the main derivation for building the software. You can
enter a shell with the software compiled with `nix-shell`.

Right now, since this project is incomplete, this will fail. To diagnose and
experiment, you can `nix-shell package.nix`, which will fetch the dependencies
defined for the project and give you an interactive shell.
