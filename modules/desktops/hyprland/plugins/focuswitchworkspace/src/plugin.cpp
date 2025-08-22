#include <hyprland/src/plugins/PluginAPI.hpp>

// Entry point required by Hyprland
APICALL EXPORT PLUGIN_DESCRIPTION_INFO PLUGIN_INIT(HANDLE handle) {
    PLUGIN_DESCRIPTION_INFO info;
    info.name = "MinimalPlugin";
    info.description = "A minimal Hyprland plugin";
    info.author = "MeRay";
    info.version = "25.08.22.01";

    return info;
}