import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:play_flutter/base/get/get_common_view.dart';
import 'package:play_flutter/pages/webview_page/webview_logic.dart';
import 'package:play_flutter/res/assets_res.dart';
import 'package:play_flutter/res_custom/colors.dart';
import 'package:play_flutter/res_custom/shadow_style.dart';
import 'package:play_flutter/res_custom/strings.dart';
import 'package:play_flutter/res_custom/style.dart';
import 'package:play_flutter/utils/navigate_utils.dart';
import 'package:play_flutter/utils/toast_util.dart';
import 'package:play_flutter/utils/web_util.dart';

class WebViewBottomWidgetWidget extends GetCommonView<WebViewLogic> {
  const WebViewBottomWidgetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Box.hBox20,
          Expanded(
              child: GestureDetector(
            onTap: () => ToastUtil.show(StringStyles.webNotComment.tr),
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  StringStyles.webEditHint.tr,
                  style: Styles.style_B8C0D4_14,
                ),
                decoration: const BoxDecoration(
                  color: ColorStyle.colorShadow,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                )),
          )),
          Box.hBox20,
          InkWell(
            onTap: () => controller.collectArticle(),
            child: Obx(() => SvgPicture.asset(
                  controller.isCollect.value ? AssetsRes.COLLECT : AssetsRes.COLLECT_QUIT,
                  width: 24,
                )),
          ),
          Box.hBox20,
          InkWell(
              onTap: () => ToastUtil.show(StringStyles.notSupportLikes.tr),
              child: const Icon(
                Icons.thumb_up_alt_outlined,
                color: ColorStyle.color_24CF5F,
                size: 24,
              )),
          Box.hBox20,
          InkWell(
            onTap: () => WebUtil.launchInBrowser(controller.detail.link),
            child: const Icon(
              Icons.public,
              color: Colors.blue,
              size: 24,
            ),
          ),
          Box.hBox20,
        ],
      ),
      decoration: ShadowStyle.white12Circle(radius: 5),
    );
  }
}
