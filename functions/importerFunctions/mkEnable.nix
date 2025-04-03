{
  lib,
  cfg,
  aPath,
  ...
}:
{opt.enable = lib.mkEnableOption (lib.last aPath);} // lib.optionalAttrs cfg.enable