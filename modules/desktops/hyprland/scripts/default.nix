{ pkgs
, lib
, mapDir
, ...
}: {
  environment.systemPackages = [ 
      pkgs.jq
    ] ++ lib.mapAttrsToList (pkgs.writeShellScriptBin) (mapDir ./. ({tf,...}: tf.script));
}