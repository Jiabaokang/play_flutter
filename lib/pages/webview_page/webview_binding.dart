import 'package:get/get.dart';
import 'package:play_flutter/pages/webview_page/webview_logic.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebViewLogic());
  }
}
