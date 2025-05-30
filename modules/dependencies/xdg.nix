{ pkgs
, lib
, config
, ... 
}@set: 
let

in 
{
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    ELECTRON_ENABLE_USE_PORTAL = "1";
  };
}