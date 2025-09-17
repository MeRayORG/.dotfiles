{ mkEnable
, config
, ...
}:
mkEnable config ["mods" "node" "bluetooth"] {
  # if bluetooth bluez error -> rfkill block bluetooth && rfkill block bluetooth  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
