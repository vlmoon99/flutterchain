#include "include/flutterchain/flutterchain_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutterchain_plugin.h"

void FlutterchainPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutterchain::FlutterchainPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
