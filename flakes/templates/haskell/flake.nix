{
  description = "DevShells";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: let 
          pkgs = import nixpkgs {inherit system;};
          
          inherit (pkgs) mkShell lib;
############
# Packages #
############
packages = [
  (with pkgs; [
    (with haskell.packages.ghc984; [
      (ghcWithPackages dependencies) # GHC compiler in the desired version (will be available on PATH)
      ghcid # Continuous terminal Haskell compile checker
      ormolu # Haskell formatter
      hlint # Haskell codestyle checker
      hoogle # Lookup Haskell documentation
      haskell-language-server# LSP server for editor
      implicit-hie # auto generate LSP hie.yaml file from cabal
      retrie # Haskell refactoring tool
      cabal-install
    ])
  ])
] ++ lib.mapAttrsToList (pkgs.writeShellScriptBin) scripts;

##################
# Define scripts #
##################
scripts = {

} // buildTargetScripts;


################
# Dependencies #
################
# must be a derivation
# add p. if from nixpackages
dependencies = p: [ 
  p.composition # for .:
  ];

#################
# Build Targets #
#################
buildTargets = {
  targetName = rec { # change to the command name you want to launch
    ghc-arg = [];     # arguments to pass to ghc
    build   = "";     # build script to override
    run     = "./${root}/Main";     # run script to override
    main    = "Main"; # name of the entrypoint 
    include = [];     # subdirs to include
    root    = ".";    # the buildtarget root
  };
};

#############
# ShellHook #
#############
extraShellHook = ''

'';



buildTargetScripts = 
     lib.mapAttrs' (name: {buildscript, ...}: lib.nameValuePair "build-${name}"  buildscript) buildTargetsOut
  // lib.mapAttrs' (name: {runscript  , ...}: lib.nameValuePair "run-${name}"    runscript  ) buildTargetsOut
  // lib.mapAttrs' (name: {launch     , ...}: lib.nameValuePair name             launch     ) buildTargetsOut;



fallBack = s1: s2: if (s1 != "") then s1 else s2;


buildTargetsOut = lib.mapAttrs (name: {
  ghc-arg  ? [],
  build    ? "",
  run      ? "",
  main     ? "Main",
  include  ? [],
  root     ? ".",
  ...
}: rec {

  ghc-args = map (arg: "-${arg}" ) ghc-arg;
  includes = map (inc: "-i${root +"/"+ inc}") ([""] ++ include);

  args = ghc-args ++ includes;
  rm = root + "/" + main;

  buildscript = fallBack build "
    ghc \"${rm}.hs\" ${lib.concatStringsSep " " args} -main-is ${main} -outputdir ${root}/build -o ${rm} &&
    chmod +x ${rm}.hs 
  ";
  runscript = fallBack run "
    ./${rm}
  ";
  launch = "build-${name} && run-${name}";
  
  hie =
  ''
  # BuildTarget: ${name} [${main}] in /${root}
      - path: "${root}"
        config:
          cradle:
            direct:
              arguments:
                - ${lib.concatStringsSep "\n              - " args} 
  '';
}) buildTargets;

in {
 
devShell = mkShell {
  inherit packages;
  shellHook = ''
    ln -sf ${ pkgs.writeText "hie.yaml" 
      ''
      cradle:
        multi:
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (_: {hie,...}: hie) buildTargetsOut)}
      ''} hie.yaml
    ${extraShellHook}
  '';
};




});}
