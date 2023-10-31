{
  description = "sokol headers and various related utils";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    sokol-src = {
      url = "github:floooh/sokol";
      flake = false;
    };

    sokol-tools-src = {
      url = "git+https://github.com/floooh/sokol-tools?submodules=1";
      flake = false;
    };

    fips-src = {
      url = "github:floooh/fips/master";
      flake = false;
    };

    handmade-math-src = {
      url = "github:HandmadeMath/HandmadeMath/v2.0.0";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (import ./overlays.nix inputs)
        ];
      };
    in {
      packages = {
        inherit (pkgs.pkgsMusl) sokol-tools;
        inherit (pkgs) sokol handmade-math;
      };

      overlays.default = import ./overlays.nix inputs;
    });
}
