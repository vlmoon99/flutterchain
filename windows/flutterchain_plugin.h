#ifndef FLUTTER_PLUGIN_FLUTTERCHAIN_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTERCHAIN_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutterchain {

class FlutterchainPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterchainPlugin();

  virtual ~FlutterchainPlugin();

  // Disallow copy and assign.
  FlutterchainPlugin(const FlutterchainPlugin&) = delete;
  FlutterchainPlugin& operator=(const FlutterchainPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutterchain

#endif  // FLUTTER_PLUGIN_FLUTTERCHAIN_PLUGIN_H_
