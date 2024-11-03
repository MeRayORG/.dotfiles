{
  inputs,
  ...
}: let
  inherit (inputs) home;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meray = {
    isNormalUser = true;
    description = "Merlin Raymond";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [    ];
  } // (builtins.hasAttr "home" inputs) {
    home-manager.nixosModules.home-manager.home-manager.username = "meray";
    home-manager.nixosModules.home-manager.home-manager.homeDirectory = "/home/meray";

  };
}
