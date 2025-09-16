{
  description = "DevShells";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: let 
          pkgs = import nixpkgs {inherit system;};
          
          inherit (pkgs) mkShell lib;

# All packages needed for this project
packages = [
  (with pkgs; [
    (with haskell.packages.ghc984; [
      ghc # GHC compiler in the desired version (will be available on PATH)
      ghcid # Continuous terminal Haskell compile checker
      ormolu # Haskell formatter
      hlint # Haskell codestyle checker
      hoogle # Lookup Haskell documentation
      haskell-language-server # LSP server for editor
      implicit-hie # auto generate LSP hie.yaml file from cabal
      retrie # Haskell refactoring tool
      cabal-install
    ])
  ])
] ++ lib.mapAttrsToList (pkgs.writeShellScriptBin) scripts
  ++ totalDeps;

# Define scripts
scripts = {

} // buildTargetScripts;

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


buildTargetScripts = 
     lib.mapAttrs' (name: {buildscript, ...}: lib.nameValuePair "build-${name}"  buildscript) buildTargetsOut
  // lib.mapAttrs' (name: {runscript  , ...}: lib.nameValuePair "run-${name}"    runscript  ) buildTargetsOut
  // lib.mapAttrs' (name: {launch     , ...}: lib.nameValuePair name             launch     ) buildTargetsOut;
buildTargetsOut = lib.mapAttrs targetOut buildTargets;

totalDeps = lib.concatLists ( lib.mapAttrsToList (_: {dependencies? [],...}: dependencies) buildTargets);

fallBack = s1: s2: if (s1 != "") then s1 else s2;


targetOut = name: {
  ghc-arg  ? [],
  build    ? "",
  run      ? "",
  main     ? "Main",
  include  ? [],
  root     ? ".",
  ...
}: rec {
includes = map (inc: "-i${root +"/"+ inc}") ([""] ++ include);
ghc-args = map (arg: "-${arg}" ) ghc-arg;
rm = root + "/" + main;
buildscript = fallBack build "
  ghc \"${rm}.hs\" ${lib.concatStringsSep " " (ghc-args ++ includes)} -main-is ${main} -outputdir ${root}/build -o ${rm} &&
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
              - ${lib.concatStringsSep "\n              - " (ghc-args ++ includes)} 
'';
};

in {
 
devShell = mkShell {
  inherit packages;
  LD_LIBRARY_PATH = lib.makeLibraryPath totalDeps;
  shellHook = ''
    ln -sf ${ pkgs.writeText "hie.yaml" 
      ''
      cradle:
        multi:
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList (_: {hie,...}: hie) buildTargetsOut)}
      ''} hie.yaml
    

  '';
};




});}
