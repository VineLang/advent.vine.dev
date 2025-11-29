{
  typix,
  hyptyp,
  flake-utils,
  pkgs,
  system,
}:
let

  typixLib = typix.lib.${system};

  hyptypLib = hyptyp.lib.${system} typixLib;

  commonArgs = {
    typstSource = "docs/main.typ";

    typstOpts = {
      features = [ "html" ];
    };

    fontPaths = [
      "${pkgs.atkinson-hyperlegible}/share/fonts/opentype"
      "${pkgs.atkinson-hyperlegible-mono}/share/fonts/opentype"
    ];

    virtualPaths = [
      {
        dest = "docs/deps/hyptyp";
        src = hyptypLib.hyptyp-typst;
      }
    ];
  };

  watchArgs = commonArgs // { };

  buildArgs = commonArgs // {
    src = pkgs.lib.fileset.toSource {
      root = ../.;
      fileset = ./.;
    };
  };
in
{
  packages = {
    docs = hyptypLib.buildHyptypProject buildArgs;
    docs-pdf = typixLib.buildTypstProject buildArgs;
  };

  apps = {
    docs = flake-utils.lib.mkApp {
      drv = hyptypLib.watchHyptypProject watchArgs;
    };
    docs-pdf = flake-utils.lib.mkApp {
      drv = typixLib.watchTypstProject watchArgs;
    };
  };
}
