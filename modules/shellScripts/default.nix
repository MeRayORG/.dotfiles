{ defImp
, config
, mapDir
, lib
, pkgs
, ... 
}@set:
{
  environment.systemPackages = 
    lib.mapAttrsToList 
        (pkgs.writeShellScriptBin) 
        ( 
            (mapDir
                ./barescripts 
                ({tf,...}: 
                    tf.script
                )
            )
            //
            (mapDir 
                ./funcscripts 
                ({ data, tf, ...}: 
                    tf.func (data set)
                )
            )
        );


}


