{ pkgs
, config
, mkHome
, ...
}:{
  xdg.mime.enable = true;
  environment = {
    systemPackages = [ pkgs.vscodium ];
    variables = {
      SYSTEMD_EDITOR = "codium";
      EDITOR = "codium";
      VISUAL = "codium";
    };
  };
} // mkHome config {
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