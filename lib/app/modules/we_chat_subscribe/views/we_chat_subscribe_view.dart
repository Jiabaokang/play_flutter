import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/we_chat_subscribe_controller.dart';

class WeChatSubscribeView extends GetView<WeChatSubscribeController> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeChatSubscribeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'WeChatSubscribeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
