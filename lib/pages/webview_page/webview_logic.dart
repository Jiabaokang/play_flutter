import 'package:get/get.dart';
import 'package:play_flutter/base/get/getx_controller_inject.dart';
import 'package:play_flutter/model/base_model/web_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLogic extends BaseGetController {
  ///加载URL
  WebModel detail = Get.arguments;

  ///WebView控制器
  late WebViewController webViewController;

  ///进度条
  var progress = 0.0.obs;

  ///是否点赞
  var isLike = false.obs;

  ///收藏状态
  var collectState = false.obs;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()..loadRequest(Uri.parse(detail.link));
    isLike.value = detail.isCollect;
  }

  ///收藏和取消收藏
  collectArticle() {
    if (!isLike.value) {
      collectState.value = true;
      Future.delayed(const Duration(milliseconds: 900)).then((value) {
        collectState.value = false;
      });
    }
    // todo 收藏和取消收藏
    // request.collectArticle(detail.id).then((value){
    //   isLike.value = !isLike.value;
    // });
  }
}
