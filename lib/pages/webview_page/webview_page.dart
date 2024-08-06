import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:play_flutter/base/get/get_common_view.dart';
import 'package:play_flutter/pages/webview_page/webview_logic.dart';
import 'package:play_flutter/pages/webview_page/widgets/webview_bottom_widget.dart';
import 'package:play_flutter/res/assets_res.dart';
import 'package:play_flutter/res_custom/colors.dart';
import 'package:play_flutter/utils/toast_util.dart';
import 'package:play_flutter/widget/_toolbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetCommonView<WebViewLogic> {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(controller.detail.title),
      // ),
      // body: WebViewWidget(controller: controller.webViewController),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                ToolBar(
                  title: controller.detail.title,
                  backColor: ColorStyle.color_474747,
                  backOnTap: () {
                    Get.back(result: '${controller.isCollect}');
                  },
                ),
                Positioned(
                  right: 24,
                  bottom: 16,
                  width: 24,
                  height: 24,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: ColorStyle.color_E2E3E8_66,
                    onTap: () {
                      Share.shareUri(Uri.parse(controller.detail.link));
                      //Share.share(controller.detail.link, subject: controller.detail.title);
                    },
                    child: SvgPicture.asset(
                      AssetsRes.SHARE,
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: controller.webViewController),
                  Obx(() => Visibility(
                        visible: controller.collectState.value,
                        child: Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Lottie.asset(
                            AssetsRes.COLLECT,
                            animate: controller.collectState.value,
                          ),
                        ),
                      )),
                  Obx(() => Visibility(
                        visible: controller.progress.value < 1,
                        child: LinearProgressIndicator(
                          minHeight: 2,
                          backgroundColor: ColorStyle.color_F9F9F9,
                          color: ColorStyle.color_24CF5F,
                          value: controller.progress.value,
                        ),
                      ))
                ],
              ),
            ),
            Visibility(
              visible: controller.detail.id > 0,
              child: WebViewBottomWidgetWidget(),
            )
          ],
        ),
      ),
    );
  }
}
