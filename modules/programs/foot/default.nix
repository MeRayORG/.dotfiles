{ pkgs
, mkHome
, config
, ...  
}@set:
{
  environment.systemPackages = [ pkgs.foot];
} //
mkHome set {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12"; # any full Nerd Font is fine
        pad  = "3x3";                             # kills the grey stripes

        # If you once experimented with these, delete or leave them commented:
        # "line-height"            = "...";
        # "vertical-letter-offset" = "...";
      };
    }; 
  };
}