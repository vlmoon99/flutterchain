import "package:web/web.dart";

Future<void> replaceCurrentTab(String initialUrl) async {
  window.open(initialUrl, '_self');
}
