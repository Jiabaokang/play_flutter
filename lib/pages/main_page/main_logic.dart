import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../base/get/getx_controller_inject.dart';

class MainLogic extends BaseGetController {

  var currentIndex = 0.obs;

  void changePage(int index,) {
    currentIndex.value = index;
  }

  //记录最后的点击事件
  DateTime? lastTime;

}
