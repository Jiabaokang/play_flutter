import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';

import 'home_first_logic.dart';

class HomeFirstPage extends GetSaveView<HomeFirstLogic> {

  const HomeFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.orange,
      child: const Center(child: Text("这是首页")),
    );
  }
}
