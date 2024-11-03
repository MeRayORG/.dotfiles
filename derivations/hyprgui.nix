{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "hyprgui";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "hyprutils"; 
    repo = "hyprgui";  
    rev = "v0.1.5";
    sha256 = "";
  };

  cargoHash = "";

  # meta = with lib; {
  #   description = "Hyprland GUI config tool";
  #   homepage = "https://github.com/hyprutils/hyprgui/";
  #   license = licenses.gpl2ClasspathPlus;
  #   maintainers = [ maintainers.meray ];
  # };
}
