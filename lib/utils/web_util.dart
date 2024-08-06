import 'package:get/get.dart';
import 'package:play_flutter/model/base_model/web_model.dart';
import 'package:play_flutter/model/home_model/banner_bean.dart';
import 'package:play_flutter/model/home_model/collect_model.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/routes/app_routes.dart';
import 'package:play_flutter/utils/save/sp_util.dart';
import 'package:url_launcher/url_launcher.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/9 10:41
/// desc   : web工具
class WebUtil {
  ///普通页面进入Web页面1
  static toWebPage(ProjectDetail detail, {Function(bool)? onResult}) {
    Get.toNamed(AppRoutes.webViewPage,
        arguments: WebModel(
          title: detail.title,
          link: detail.link,
          id: detail.id,
          isCollect: detail.collect,
        ))?.then((value) async {
      if (value is bool && onResult != null) {
        onResult(value);
      }
    });

    ///存储浏览记录
    SpUtil.saveBrowseHistory(detail);
  }

  ///收藏页面进入Web页面2
  static Future<dynamic>? toWebPageCollect(CollectDetail detail) {
    return Get.toNamed(AppRoutes.webViewPage,
        arguments: WebModel(
          title: detail.title,
          link: detail.link,
          id: detail.id,
          originId: detail.originId,
          isCollect: true,
        ));
  }

  ///普通页面进入Web页面2
  static toWebPageBanners(BannerBean detail) {
    Get.toNamed(AppRoutes.webViewPage,
        arguments: WebModel(
          title: detail.title,
          link: detail.url,
          id: 0,
          isCollect: false,
        ));
  }

  ///其他页面进入Web页面2
  static toWebPageOther({String title = '', String link = ''}) {
    Get.toNamed(AppRoutes.webViewPage,
        arguments: WebModel(
          title: title,
          link: link,
          id: 0,
          isCollect: false,
        ));
  }

  ///打开浏览器
  ///[url] 访问链接
  static Future<void> launchInBrowser(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "无法找到:$url";
    }
  }
}
