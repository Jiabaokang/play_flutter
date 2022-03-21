import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/res/strings.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/19 22:25
/// desc   : 缓存工具类
class CacheUtils {

  ///保存assets图片到本地
  ///[assets] assets路径
  ///[target] 目标路径
  static saveAssetsGallery(
      {BuildContext? context, String assets = '', String target = ''}) async {
    ByteData bytes = await rootBundle.load(assets);
    final result =
        await ImageGallerySaver.saveImage(bytes.buffer.asUint8List());

    showToast(StringStyles.saveSuccess.tr, context: context);
  }
}
