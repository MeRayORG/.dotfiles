{ config, lib, pkgs, ... }: with lib;

{

    environment.systemPackages = with pkgs; [
      rclone
    ];

}
