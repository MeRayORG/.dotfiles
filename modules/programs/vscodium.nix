{ pkgs
, config
, mkHome
, ...
}:
let
    codeBin = "${pkgs.vscodium}/bin/codium";
in
{
  xdg.mime.enable = true;
  environment = {
    systemPackages = [ pkgs.vscodium ];
    variables = {
      SYSTEMD_EDITOR = codeBin;
      EDITOR = codeBin;
      VISUAL = codeBin;
    };
  };
} // mkHome config {
  programs.git = {
    settings = {
      core = {
        editor = codeBin;
      };

      # [diff]
      diff = {
        tool = "codium";
      };

      # [difftool]
      difftool = {
        prompt = false;
        # [difftool "codium"]
        codium = {
          cmd = "${codeBin} --wait --diff \$LOCAL \$REMOTE";
        };
      };
    };
  };
}