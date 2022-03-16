import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/controller/base_page_controller.dart';
import 'package:play_flutter/base/get/getx_controller_inject.dart';


/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 11:28
/// desc   : 组合页面 控制器层
class HomeFirstLogic extends BaseGetPageController {

  ///首页Banner数据
  /// todo

  @override
  void onInit() {
    super.onInit();
    getBannerData();
  }

  //获取Banner数据
  void getBannerData() {

  }


}

