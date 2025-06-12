{ pkgs
, mkHome
, lib
, config
, ...  
}@set:
{ 
  config = lib.mkIf (config.mods.programs.terminal.which == "kitty") ({
    environment.systemPackages = [ pkgs.kitty];
  } // mkHome set {
    ## SET cursormode, font, reflow
  });
}
