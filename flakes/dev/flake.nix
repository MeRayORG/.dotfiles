{
  description = "DevShells";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: let 
          pkgs = import nixpkgs {inherit system;};
          inherit (pkgs) mkShell;
        in { devShells = {

haskell = mkShell {
  buildInputs = [       
      pkgs.haskell.compiler.ghc983
      pkgs.haskell-language-server
      pkgs.cabal-install
      pkgs.hlint
      pkgs.ghci
      
  ];
};




};});}
