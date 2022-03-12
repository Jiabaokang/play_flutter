import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 16:32
/// desc   :
///
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: ListTile(
        title: Text("返回首页"),
        subtitle: Text('Get.offAllNamed(AppRoutes.Home)'),
        onTap: () => Get.offAllNamed(AppRoutes.mainTabNav),
      ),
    );
  }
}