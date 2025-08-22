{ lib
, pkgs
, hyprland
, pkg-config 
}:
let 
  name = "focuswitchworkspace";
  pname = name;
  pluginName = name;
in
hyprland.stdenv.mkDerivation {
  inherit name pname pluginName;
  version = "25.08.22.01";

  src = ./src;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ hyprland ] ++ hyprland.buildInputs;


  dontConfigure = true;

  buildPhase = ''
          g++ -std=c++23 -fPIC -shared plugin.cpp -o ${name}.so \
            -I${pkgs.hyprland}/include
  '';

  installPhase = ''
    install -Dm644 ${name}.so \
      $out/lib/hyprland/plugins/${name}.so
  '';

  meta = {
    description = "Hyprland plugin: extend focus switching across workspaces";
    license = lib.licenses.cc-by-nc-sa-40;
    platforms = lib.platforms.linux;
  };
}
