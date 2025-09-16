{
  description = "Haskell DevEnv";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: let 
          pkgs = import nixpkgs {inherit system;};
          
          inherit (pkgs) mkShell lib;

## Needed when working with non-nix devs 
withNonNixDevs = false;
stack-wrapped = pkgs.symlinkJoin {
          name = "stack"; # will be available as the usual `stack` in terminal
          paths = [ pkgs.stack ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/stack \
              --add-flags "\
                --no-nix \
                --system-ghc \
                --no-install-ghc \
              "
          '';
        };

# All packages needed for this project
packages = [
  (with pkgs; [
    (with haskell.packages.ghc984; [
      ghc # GHC compiler in the desired version (will be available on PATH)
      ghcid # Continuous terminal Haskell compile checker
      ormolu # Haskell formatter
      hlint # Haskell codestyle checker
      hoogle # Lookup Haskell documentation
      haskell-language-server # LSP server for editor
      implicit-hie # auto generate LSP hie.yaml file from cabal
      retrie # Haskell refactoring tool
    ])
  ])
   
  "${if withNonNixDevs then stack-wrapped else pkgs.stack}"
] ++ lib.mapAttrsToList (pkgs.writeShellScriptBin) scripts;


# Define scripts
scripts = {
  run = ''
    cd $(root)
    build &&
    ./Main
  '';
  build = ''
    arg=''${1:-"Main"}
    ghc "$arg.hs" -outputdir build -main-is "$arg" &&
    chmod +x $arg
  '';
  root = ''
    cd $(git rev-parse --show-toplevel)
  '';
};


in {
 
devShell = mkShell {
  inherit packages;
};




});}
