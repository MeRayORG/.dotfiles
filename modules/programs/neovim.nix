{pkgs, ...}:
{
  environment= {
    systemPackages = with pkgs; [
      neovim
      wl-clipboard-rs

      # Lazygit
      luajitPackages.luarocks
      ripgrep
      fd
      lazygit

      gcc


    ];
    variables = {
        SUDO_EDITOR = "nvim";
        SYSTEMD_EDITOR = "nvim";
        EDITOR = "nvim";
        VISUAL = "nvim";
    };
  };
}
