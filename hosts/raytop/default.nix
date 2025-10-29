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
  
    python3

    vscodium


    rclone
    tree
    eza
    unrar

    

    ### imageediting
    gimp
    inkscape
    rawtherapee
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
  

    #### send notifications using notify-send 
    # Note: Wtf have the devs of this tool been smoking??
    # "It's documented as such but won't fix because ... Reasons?"
    # > notify-send -u critical -t 0  
    # sends a sticky notification
    libnotify
    
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  mods = {
    programs = {
      terminal.which = "ghostty";
    };
    flakeDir = "~/nixconf/.";
    desktops.de = "cosmic"; # "hypr" "cosmic" "gnome" "kde" "hyde" "niri" "none"

    services.keyd = {
      mode = {
        edit = {
          enable = true;
          space = true;
        };
        accents = true;
      };
      mod = {
        homeRow.enable = true;
        spaceNext = true;
        invertNumbers = true;
      };
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
        size = 15;
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


  # Binary Cache for haskell.nix
  nix.settings.trusted-public-keys = ["hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="];
  nix.settings.substituters = ["https://cache.iog.io"];

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
