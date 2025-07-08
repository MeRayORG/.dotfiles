{ pkgs
, mkHome
, lib
, config
, ...  
}:
{ 
  config = lib.mkIf (config.mods.programs.terminal.which == "kitty") ({
    environment.systemPackages = [ pkgs.kitty];
  } // mkHome config {
    ## SET cursormode, font, reflow
  });
}
