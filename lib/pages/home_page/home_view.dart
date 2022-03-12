import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/get/get_save_state_view.dart';
import '../../widget/pull_smart_refresher.dart';
import 'home_logic.dart';

class HomePage extends GetSaveView<HomeLogic> {

  HomePage({Key? key}) : super(key: key);

  final List<String> strList = ['你好', 'java', 'kotlin', 'ObjectC', 'Go', 'Swi'];

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return Scaffold(
      body: Container(
        color: Colors.orange,

              child: ListView.builder(
                  itemCount: strList.length,
                  itemBuilder: (context, index) => Text(strList[index])))

    );
  }
}



