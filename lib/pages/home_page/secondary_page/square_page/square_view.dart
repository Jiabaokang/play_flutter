import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';

import 'square_logic.dart';

class SquarePage extends GetSaveView<SquareLogic> {
  const SquarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(SquareLogic());

    return Container();
  }
}
