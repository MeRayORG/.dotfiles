{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    home = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyperland.url = "github:hyprwm/Hyprland";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05"
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    ags.url = "github:Aylur/ags";
  };

  outputs = {... }@inputs :
  let
    # super simple boilerplate-reducing
    # lib with a bunch of functions
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        raytop = mkSystem ./hosts/raytop/configurations/normal.nix;
        # work = mkSystem ./hosts/work/configuration.nix;
        # vps = mkSystem ./hosts/vps/configuration.nix;
        # liveiso = mkSystem ./hosts/liveiso/configuration.nix;
      };

      # homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
  
}
