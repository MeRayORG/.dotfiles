{
  lib,
  cfg,
  aPath,
  ...
}:
3{opt.enable = lib.mkEnableOption (lib.last aPath);} // lib.optionalAttrs cfg.enable