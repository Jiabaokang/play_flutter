import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:play_flutter/base/get/get_extension_method.dart';
import 'package:play_flutter/res_custom/button_style.dart';
import 'package:play_flutter/res/r.dart';
import 'package:play_flutter/res_custom/colors.dart';
import 'package:play_flutter/res_custom/strings.dart';
import 'package:play_flutter/res_custom/style.dart';
import 'package:play_flutter/utils/file/cache_utils.dart';
import 'package:play_flutter/utils/navigate_utils.dart';
import 'package:play_flutter/widget/dialog/base_dialog.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/19 15:07
/// desc   : 分享数据对话框
class ShareDialog extends StatelessWidget {
  final String url;

  const ShareDialog({Key? key, this.url = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Box.vBox30,
        Text(
          StringStyles.shareApplication.tr,
          style: Styles.style_black_16,
        ),
        Box.vBox5,
        Text(
          StringStyles.shareHint.tr,
          style: Styles.style_B8C0D4_14,
        ),
        Box.vBox10,
        Image.asset(
          R.assetsImagesShareQRCode,
          width: 120,
          height: 120,
        ),
        Box.vBox20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///浏览器图标
            _buildShareIcon(Icons.public_sharp, ColorStyle.color_24CF5F, StringStyles.openBrowser.tr,
                () => Navigate.launchInBrowser(url)),

            ///保存到本地的图标
            _buildShareIcon(
                Icons.download,
                ColorStyle.color_FE8C28,
                StringStyles.shareSaveLocal.tr,
                () => {
                      ///申请存储权限
                      Permission.storage.request().then((value) async {
                        ///存储权限申请成功后，保存图片到本机中
                        if (value.isGranted) {
                          CacheUtils.saveAssetsGallery(assets: R.assetsImagesShareQRCode);
                        } else {
                          ///打开设置界面
                          openAppSettings();
                          // if (await Permission.speech.isPermanentlyDenied) {
                          //   openAppSettings();
                          // }
                        }
                      })
                    }),
          ],
        ),
        Box.vBox30,
        DividerStyle.divider1Half,
        SizedBox(
          width: double.infinity,
          height: 60,
          child: TextButton(
            style: ButtonStyles.getNoShapeStyle(),
            onPressed: () => Get.dismiss(),
            child: Text(StringStyles.actionCancel.tr, style: Styles.style_black_14),
          ),
        )
      ],
    ));
  }

  ///返回手势检测器
  GestureDetector _buildShareIcon(IconData icon, Color color, String text, VoidCallback onTab) {
    return GestureDetector(
      onTap: onTab,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: ColorStyle.colorShadow,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Icon(icon, color: color, size: 30)),
          Box.vBox10,
          Text(text, style: Styles.style_black_16),
        ],
      ),
    );
  }
}
