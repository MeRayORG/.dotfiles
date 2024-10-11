let

    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
in
haumea.lib.load {
  src = ./modules;
  inputs = {
    pkgs = nixpkgs;
    inherit (nixpkgs) lib;
  };
}

