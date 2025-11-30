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
    syt = hyptypLib.buildHyptypProject buildArgs;
    syt-pdf = typixLib.buildTypstProject buildArgs;
  };

  apps = {
    syt = flake-utils.lib.mkApp {
      drv = hyptypLib.watchHyptypProject watchArgs;
    };
    syt-pdf = flake-utils.lib.mkApp {
      drv = typixLib.watchTypstProject watchArgs;
    };
  };
}
