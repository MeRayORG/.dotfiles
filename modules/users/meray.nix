{config, pkgs, ...}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meray = {
    isNormalUser = true;
    description = "Merlin Raymond";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [    ];
  };
}
