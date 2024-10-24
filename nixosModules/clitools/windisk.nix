{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    ntfs3g
    dosfstools
  ];

  # Optional: Ensure FUSE is enabled
  boot.supportedFilesystems = [ "ntfs" "fuse" ];
}
