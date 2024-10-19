{
  description = "Ryan's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # home-manager, used for managing user configuration
    home = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    #let
    #  mods = haumea.lib.load {
    #    src = ./modules;
    #    inputs = {
    #       pkgs = nixpkgs;
    #      inherit home;
    #  };
    #}
        
    #in
      {
      nixosConfigurations = {
        "raynix" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Import the configuration.nix here, so that the
            # old configuration file can still take effect.
            # Note: configuration.nix itself is also a Nix Module,
            ./configuration.nix
          ];
        };
        gaming = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Import the configuration.nix here, so that the
            # old configuration file can still take effect.
            # Note: configuration.nix itself is also a Nix Module,
            ./gaming.nix
          ];
        };

      };
  };
}
