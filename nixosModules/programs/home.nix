{
  config,
  pkgs,
  inputs,
  myLib,
  lib,
  ...
}: {
  options.myNixOS = {
    users.hmUser = lib.mkOption {
      default = throw "set HomeUser";
      type = lib.types.str;
    };
  };
}