abstract class JsVMService {
  Future<void> init();

  Future<dynamic> callJS(String function);

  Future<dynamic> callJSAsync(String function);
}
