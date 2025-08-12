{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    ntfs3g
    dosfstools
    btrfs-progs
  ];

  # Optional: Ensure FUSE is enabled
  boot.supportedFilesystems = [ "ntfs" "fuse" ];
}
