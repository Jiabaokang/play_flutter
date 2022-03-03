import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_tab_nav_controller.dart';

class MainTabNavView extends GetView<MainTabNavController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainTabNavView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MainTabNavView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
