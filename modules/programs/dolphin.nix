{ pkgs
, mkHome
, config
, ...  
}@set:
{
  environment.systemPackages = [ 
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.ark

    ];
  
}