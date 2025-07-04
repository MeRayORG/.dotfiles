{ config
, lib
, ...
}: 
let 
cfg = config.mods.theme; 
inherit (lib.types) oneOf path enum;
in
{
  config = {
    stylix = { 
      image = cfg.wallpaper;
    };
    mods.theme.wallpaper = ./../src/weirdpalm.jpg;
  };
  options.mods.theme.wallpaper = lib.mkOption {
    type = path;
  };

}