import 'package:get/get.dart';
import 'package:play_flutter/base/get/getx_controller_inject.dart';
import 'package:play_flutter/model/base_model/web_model.dart';
import 'package:play_flutter/res_custom/strings.dart';
import 'package:play_flutter/utils/toast_util.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/src/platform_navigation_delegate.dart';

class WebViewLogic extends BaseGetController {
  ///加载URL
  WebModel detail = Get.arguments;

  ///WebView控制器
  late WebViewController webViewController;

  ///进度条
  var progress = 0.0.obs;

  ///是否点赞
  var isCollect = false.obs;

  ///收藏状态
  var collectState = false.obs;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..loadRequest(Uri.parse(detail.link))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            this.progress.value = progress / 100;
          },
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );

    isCollect.value = detail.isCollect;
  }

  ///收藏和取消收藏
  collectArticle() {
    if (!isCollect.value) {
      collectState.value = true;
      Future.delayed(const Duration(milliseconds: 900)).then((value) {
        collectState.value = false;
      });
    }
    //收藏进入取消收藏的ID是originId
    int detailId = (isCollect.value && detail.originId != 0) ? detail.originId : detail.id;
    request.collectArticle(
      detailId,
      isCollect: isCollect.value,
      success: (data) {
        var content = isCollect.value ? StringStyles.collectQuit.tr : StringStyles.collectSuccess.tr;
        ToastUtil.show(content);
        isCollect.value = !isCollect.value;
        update();
      },
    );
  }
}
