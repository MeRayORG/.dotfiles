#include <hyprland/src/plugins/PluginAPI.hpp>
#include <hyprland/src/Compositor.hpp>
#include <hyprland/src/managers/KeybindManager.hpp>

inline HANDLE PHANDLE = nullptr;

bool workspace

void focusOrMoveWorkspace(std::string args) {
    // Direction is passed like "l", "r", "u", "d"
    if (args.empty())
        return;

    char dir = args[0];
    // Try focusing normally first
    g_pKeybindManager->changewindowfocus(args);

    // If focus didn't change, move workspace
    if (!g_pCompositor->m_pLastWindow) {
        int currentWs = g_pCompositor->m_pLastMonitor->activeWorkspace;
        int newWs = currentWs;

        if (dir == 'l') newWs--;
        else if (dir == 'r') newWs++;
        else if (dir == 'u') newWs += 10; // example: treat up/down as +/- 10
        else if (dir == 'd') newWs -= 10;

        g_pCompositor->focusWorkspace(newWs);

        // focus first window there if exists
        auto pWorkspace = g_pCompositor->getWorkspaceByID(newWs);
        if (pWorkspace && !pWorkspace->m_vWindows.empty()) {
            g_pCompositor->focusWindow(pWorkspace->m_vWindows[0]);
        }
    }
}

APICALL EXPORT PLUGIN_DESCRIPTION_INFO PLUGIN_INIT(HANDLE handle) {
    PHANDLE = handle;

    // Register custom keybinds
    HyprlandAPI::addDispatcher(PHANDLE, "focusplus", focusOrMoveWorkspace);

    return {"focuswitchworkspace", "extend focus switching across workspaces", "25.08.22.01", "MeRay"};
}

APICALL EXPORT void PLUGIN_EXIT() {
    HyprlandAPI::removeDispatcher(PHANDLE, "focusplus");
}
