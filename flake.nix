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

        syt = pkgs.callPackage ./syt.nix {
          inherit
            system
            pkgs
            flake-utils
            typix
            hyptyp
            ;
        };
      in
      builtins.foldl' pkgs.lib.attrsets.recursiveUpdate
        {
          formatter = pkgs.nixfmt-tree;
        }
        [ syt ]
    );
}
