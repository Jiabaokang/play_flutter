import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/controller/base_page_controller.dart';
import 'package:play_flutter/model/home_model/banner_bean.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/res/r.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 11:28
/// desc   : 组合页面 控制器层
class HomeFirstLogic extends BaseGetPageController {

  ///首页数据
  List<ProjectDetail> projectData = [];

  ///首页Banner数据
  List<BannerBean> bannerList = [];

  @override
  void onInit() {
    super.onInit();
    getBannerData();
  }

  ///获取Banner数据
  void getBannerData() {
    request.getBanner(success: (data) {
      ///添加图片
      bannerList.add(BannerBean(
        imagePath: R.assetsImagesPoints,
        isAssets: true,
      ));
      bannerList.addAll(data);

      ///缓存图片
      if (Get.context != null) {
        for (var element in data) {
          precacheImage(NetworkImage(element.imagePath), Get.context!);
        }
      }


      //TODO 测试数据
      showSuccess(projectData);

      update();
    });
  }
}
