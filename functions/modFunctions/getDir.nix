{lib, ...}:

dir:
{
 default ? false
}:

let 
  rewrite =
  lib.mapAttrsToList
  (filename: filetype: let parts = lib.splitString "." filename; in (
    if (filetype == "directory") then {
      type = "/";
      name = filename;
      import = import dir + filename;
    } else ((
      
      if ((lib.length parts) < 2) then
        { 
          name = filename; 
          type = ""; 
          }
      else
        {
          name = lib.concatStringsSep "." (lib.init parts);
          type = lib.last parts;
        }) 
          
      // {imported = import (dir + "/${filename}");}
    )
    ) // { isNix = (filetype == "directory" || lib.hasSuffix ".nix" filename);} 
  );

  filterDefault = attrs: if default then attrs else lib.filterAttrs (f: _: f != "default.nix") attrs;
  
  
in
  rewrite 
  ( filterDefault
  (builtins.readDir dir))