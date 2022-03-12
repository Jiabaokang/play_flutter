import 'package:get/get.dart';

import 'home_logic.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 11:36
/// desc   : 启动页面
class HomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
  }
}
