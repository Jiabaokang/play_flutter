import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_logic.dart';

class UserPage extends StatelessWidget {
  final logic = Get.put(UserLogic());
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.pink[500],
    );
  }
}
