import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NestedController extends GetxController {

  static NestedController get to => Get.find();

  var currentIndex = 0.obs;

  void changePage(int index,) {
    currentIndex.value = index;

    //Get.toNamed(pages[index], id: 1);
  }

}
