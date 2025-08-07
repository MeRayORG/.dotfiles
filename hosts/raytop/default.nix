{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  environment.systemPackages = with pkgs; [

    wget
    brave

    gparted
    btrfs-progs

    git
    python3


    teams-for-linux

    vscodium


    rclone
    tree
    eza
    unrar

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

    libGL
    steam-run


    quickemu

    # 7zip Support
    p7zip

    libguestfs-with-appliance

    sshfs

    remmina

    waypipe

    whatsapp-for-linux
    btop
    
    clang
    ccls

    typst
    tinymist

    spotify

    SDL2

    calibre
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  mods = {
    programs = {
      terminal.which = "ghostty";
    };
    flakeDir = "~/nixconf/.";
    desktops.de = "hypr";

    services.keyd = {
      mode = {
        edit = {
          enable = true;
          space = true;
        };
        accents = true;
      };
      mod = {
        homeRow = true;
        spaceNext = true;
        invertNumbers = true;
      };
      nav.vim = false;
    };
    shell.zsh.enable = true;

    theme = {
      theme = {
        gtk = {
          name = "matcha";
          package = pkgs.matcha-gtk-theme;
        };
      };
      icon = {
        package = pkgs.matcha-gtk-theme;
        name = "numix";
      };
      cursor = {
        package = pkgs.layan-cursors;
        size = 16;
        name = "layan-cursors";
      };
    };

    homemanager.users = ["meray"];
  };
  # Install firefox.
  programs.firefox.enable = true;
  programs.steam.enable = true;


  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "raytop"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  # i18n = {
  #   defaultLocale = "en_US.UTF-8";

  #   extraLocaleSettings = {
  #     LC_ADDRESS = "nl_NL.UTF-8";
  #     LC_IDENTIFICATION = "nl_NL.UTF-8";
  #     LC_MEASUREMENT = "nl_NL.UTF-8";
  #     LC_MONETARY = "nl_NL.UTF-8";
  #     LC_NAME = "nl_NL.UTF-8";
  #     LC_NUMERIC = "nl_NL.UTF-8";
  #     LC_PAPER = "nl_NL.UTF-8";
  #     LC_TELEPHONE = "nl_NL.UTF-8";
  #     LC_TIME = "nl_NL.UTF-8";
  #   };
  # };
  home-manager.backupFileExtension = "hm-backup";




  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  system.stateVersion = "25.05"; # Did you read the comment?
}
