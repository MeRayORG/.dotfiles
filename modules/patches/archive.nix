{
  pkgs,
  aPath,
  ...
}: {


  environment.systemPackages = with pkgs; [
    # 7zip support
    p7zip
    # rar support
    unrar
  ];
}