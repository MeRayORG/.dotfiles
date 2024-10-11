{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [ bottles ];


}
