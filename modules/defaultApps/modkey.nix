{config, pkgs, ...}:

{
  # https://github.com/rvaiya/keyd
  environment.systemPackages = with pkgs; [ keyd ];


}
