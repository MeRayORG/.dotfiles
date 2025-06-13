{ pkgs
, ...
} @set:
{
  pkg = pkgs.hyprlandPlugins.hyprexpo;
  set = {keep_focused = true;};
}
