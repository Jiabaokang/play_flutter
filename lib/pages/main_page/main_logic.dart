import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../base/get/getx_controller_inject.dart';

class MainLogic extends BaseGetController {

  var currentIndex = 0.obs;

  void changePage(int index,) {
    currentIndex.value = index;

    //Get.toNamed(pages[index], id: 1);
  }

  //记录最后的点击事件
  DateTime? lastTime;


  // //记录选中的下标
  // final RxInt _selectedIndex = RxInt(0);
  //
  // //设置值
  // void setValue(int index) {
  //   _selectedIndex.value = index;
  // }

}
