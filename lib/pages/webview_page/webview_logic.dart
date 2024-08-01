import 'package:get/get.dart';
import 'package:play_flutter/base/get/getx_controller_inject.dart';
import 'package:play_flutter/model/base_model/web_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLogic extends BaseGetController {
  ///加载URL
  WebModel detail = Get.arguments;

  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();

    webViewController = WebViewController()..loadRequest(Uri.parse(detail.link));
  }
}
