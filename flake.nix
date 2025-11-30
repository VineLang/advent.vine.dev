{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyptyp = {
      url = "github:TendrilsCompute/hyptyp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      typix,
      hyptyp,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        typixLib = typix.lib.${system};
        hyptypLib = hyptyp.lib.${system} typixLib;

        commonArgs = {
          typstSource = "site/hyp.typ";

          typstOpts = {
            features = [ "html" ];
          };

          virtualPaths = [
            {
              dest = "site/deps/hyptyp";
              src = hyptypLib.hyptyp-typst;
            }
          ];
        };

        watchArgs = commonArgs // { };

        buildArgs = commonArgs // {
          src = pkgs.lib.fileset.toSource {
            root = ./.;
            fileset = ./site;
          };
        };
      in
      {
        formatter = pkgs.nixfmt-tree;

        packages = rec {
          default = site;
          site = hyptypLib.buildHyptypProject buildArgs;
        };

        apps = rec {
          default = site;
          site = flake-utils.lib.mkApp {
            drv = hyptypLib.watchHyptypProject watchArgs;
          };
        };
      }
    );
}
