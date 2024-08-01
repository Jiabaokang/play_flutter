import 'package:flutter/material.dart';
import 'package:play_flutter/base/get/get_common_view.dart';
import 'package:play_flutter/pages/webview_page/webview_logic.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetCommonView<WebViewLogic> {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.detail.title),
      ),
      body: WebViewWidget(controller: controller.webViewController),
    );
  }
}
