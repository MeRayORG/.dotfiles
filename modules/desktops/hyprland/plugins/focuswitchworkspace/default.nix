{ pkgs
, ...
}:
{
  pkg = (pkgs.callPackage ./derivation.nix {} );
  set = {};
}