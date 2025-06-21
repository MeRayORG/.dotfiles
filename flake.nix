{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    pkgs2411.url = "github:NixOS/nixpkgs/nixos-24.11";
    pkgs2405.url = "github:NixOS/nixpkgs/nixos-24.05";
    upkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    ags.url = "github:Aylur/ags";

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
  };

  outputs = { nixpkgs
            , stylix
            , ... 
            } @inputs :
  let
    f = import ./functions/funs inputs;
    moduleFunctions = import ./functions/modFunctions nixpkgs.lib;
  in
    {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        # raytop = f.mkSystem ./hosts/raytop;
        raytop = nixpkgs.lib.nixosSystem {
          modules = [
            #inputs.stylix.nixosModules.stylix
            ./hosts/raytop
            ./modules
          ];
          specialArgs = inputs // moduleFunctions;
        };
      };

    };
  
}
