set @ {
  pkgs,
  mkHome,
  ...
}:
{
  xdg.mime.enable = true;
  environment.systemPackages = [ pkgs.vscodium ];
} // mkHome set {
  programs.git = {
    extraConfig = {
      # [diff]
      diff = {
        tool = "codium";
      };

      # [difftool]
      difftool = {
        prompt = false;
        # [difftool "codium"]
        codium = {
          cmd = "codium --wait --diff \$LOCAL \$REMOTE";
        };
      };
    };
  };
}