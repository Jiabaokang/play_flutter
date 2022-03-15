import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'project_logic.dart';

class ProjectPage extends StatelessWidget {
  final logic = Get.put(ProjectLogic());

  @override
  Widget build(BuildContext context) {
    return Container(
     color: Colors.black,
    );
  }
}
