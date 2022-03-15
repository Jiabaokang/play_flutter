import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';

import 'ask_logic.dart';

class AskPage extends GetSaveView<AskLogic> {
  const AskPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.purple[300],
      child: const Center(child: Text("这是首页")),
    );
  }
}
