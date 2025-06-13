{ pkgs
, split-monitor-workspaces
, ...
}:
{
  pkg = split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces;
  set = {
    keep_focused = true;
    enable_persistent_workspaces = false;
  };
}