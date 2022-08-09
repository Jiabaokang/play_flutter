import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/controller/base_page_controller.dart';
import 'package:play_flutter/model/home_model/banner_bean.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/model/structure_model/wechat_public_model.dart';
import 'package:play_flutter/res/r.dart';
import 'package:play_flutter/utils/ext/refresh_extension.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 11:28
/// desc   : 组合页面 控制器层
class HomeFirstLogic extends BaseGetPageController {

  ///首页数据
  List<ProjectDetail> projectData = [];

  ///首页Banner数据
  List<BannerBean> bannerList = [];

  ///微信公众号列表
  List<WechatPublic> wechatPublic = [];

  ///当前显示的微信公众号列表
  List<WechatPublic> showWechatPublic = [];

  @override
  void onInit() {
    super.onInit();
    getBannerData();
  }

  ///当前轮播的索引
  int currentIndex = 1;

  ///插入公众号的索引
  var insertIndex = -1;

  ///获取Banner数据
  void getBannerData() {
    request.getBanner(success: (data) {
      ///添加图片
      bannerList.add(BannerBean(
        imagePath: R.assetsImagesRankingIntegral,
        isAssets: true,
      ));
      bannerList.addAll(data);

      ///缓存图片
      if (Get.context != null) {
        for (var element in data) {
          precacheImage(NetworkImage(element.imagePath), Get.context!);
        }
      }

      showSuccess(bannerList);
      update();
    });
  }


  ///请求首页项目数据
  @override
  void requestData(RefreshController controller,
      {Refresh refresh = Refresh.first}) {
    request.requestFirstPageArticle(page, success: (data, over) {
      RefreshExtension.onSuccess(controller, refresh, over);

      ///下拉刷新需要清除列表
      if (refresh != Refresh.down) {
        projectData.clear();
      }

      projectData.addAll(data);
      showSuccess(projectData);

      ///为了防止动画每次都加载，所以只需要在第一次出现时加载一次
      update();

      ///请求公众号数据
      // if (projectData.isNotEmpty && wechatPublic.isEmpty) {
      //   getWechatPublic();
      // }
    }, fail: (code, msg) {
      showFailed();
      RefreshExtension.onError(controller, refresh);
    });
  }

  ///请求完首页数据之后，请求微信公众号接口
  ///随机取首页数据中间数值插入一列为公众号数据
  // void getWechatPublic() {
  //   request.getWechatPublic(success: (data) {
  //     wechatPublic = data;
  //
  //     ///获取当前微信公众号插入索引
  //     insertIndex = getInsertIndexRandom();
  //
  //     ///获取当前显示的2个随机公众号数据
  //     showWechatPublic = getRandomPublicData(data);
  //     update();
  //   });
  // }

  ///获取随机的公众号数据
  getRandomPublicData(List<WechatPublic> data) {
    final _random = Random();
    var randomIndex = _random.nextInt(data.length - 2);
    return data.sublist(randomIndex, randomIndex + 2);
  }

}
