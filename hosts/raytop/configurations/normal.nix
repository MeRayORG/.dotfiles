{ config, pkgs, lib, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../nvidia.nix
  ];

  myNixOS = {
    myUsers.meray.enable = true;
    
    myPrograms = {
      neovim.enable = true;
      starship.enable = true;
      git.enable = true;
      windisk.enable = true;
      discord.enable = true;
      asianLangSupport.enable = true;
      nixd.enable = true;
    };
    desktops.kde.enable = true;
    shell.nush.enable = true;
  };



  environment.systemPackages = with pkgs; [

    wget
    brave

    gparted
    btrfs-progs

    git
    python3


    kate
    polkit

    teams-for-linux

    vscodium


    rclone
    kitty
    tree
    eza
    unrar

    ## create options like: mapESCtoCAPS.enable = true
    # https://github.com/rvaiya/keyd
    keyd
    ###

    prismlauncher

    ## Office
    #mkif env = hyperland or Sway
    #onlyoffice-bin
    #else
    onlyoffice-bin_latest

    gimp
    inkscape
    ###

    bottles
    steam

    libGL
    steam-run


    quickemu
    keepassxc

    # 7zip Support
    p7zip

    libguestfs-with-appliance

    sshfs
    tailscale

    remmina

    waypipe

    whatsapp-for-linux

    texliveFull

  ];

  # Install firefox.
  programs.firefox.enable = true;
  programs.steam.enable = true;


  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "raynix"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };




  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ## See extraconfig.nix
  system.stateVersion = "24.05"; # Did you read the comment?
}
