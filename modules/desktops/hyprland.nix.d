{
  pkgs,
  hyprpanel,
  ...
}:
{
  nixpkgs.overlays = [hyprpanel.overlay];
  fonts.packages = with pkgs; [ nerdfonts ];
  programs = {
    # HYPRLAND
    hyprland = {
      enable = true;
    };
    # HYPRLOCKs
    hyprlock.enable = true;
  };
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
  };
  environment.systemPackages = [ 
    pkgs.hyprpanel
    pkgs.foot
    pkgs.wofi
    pkgs.yazi



    #############
    # HYPRPANEL #
    #############
    pkgs.upower
    pkgs.wireplumber
    pkgs.libgtop
    pkgs.bluez
    pkgs.bluez-tools
    pkgs.networkmanager
    pkgs.dart-sass
    pkgs.wl-clipboard
    pkgs.upower
    pkgs.gvfs

    ## Used for Tracking GPU Usage in your Dashboard (NVidia only)
    pkgs.gpustat

    ## To control screen/keyboard brightness
    pkgs.brightnessctl

    ## Only if a pywal hook from wallpaper changes applied through settings is desired
    pkgs.pywal


    ## To switch between power profiles in the battery module
    pkgs.power-profiles-daemon

    ## To take snapshots with the default snapshot shortcut in the dashboard
    pkgs.grimblast

    ## To record screen through the dashboard record shortcut
    pkgs.wf-recorder

    ## To enable the eyedropper color picker with the default snapshot shortcut in the dashboard
    pkgs.hyprpicker

    ## To enable hyprland's very own blue light filter
    pkgs.hyprsunset

    ## To click resource/stat bars in the dashboard and open btop
    pkgs.btop

    ## To enable matugen based color theming
    pkgs.matugen

    ## To enable matugen based color theming and setting wallpapers
    pkgs.swww

  ];
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   plugins = [
  #     #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  #     # ...
  #   ];
  # };
}
