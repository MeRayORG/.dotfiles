{
  description = "DevShells";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: let 
          pkgs = import nixpkgs {inherit system;};
          
          inherit (pkgs) mkShell lib;

# All packages needed for this project
packageList = [

  
] ++ lib.mapAttrsToList (pkgs.writeShellScriptBin) scripts;

# Define scripts
scripts = {
  
  run = ''

  '';
  test = ''

  '';
  build = ''

  '';

};


        in { 
devShell = mkShell {
  packages = packageList;
};




});}
