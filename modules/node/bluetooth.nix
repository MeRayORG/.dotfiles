{ ...
}:{
  # if bluetooth bluez error -> rfkill block bluetooth && rfkill block bluetooth  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
