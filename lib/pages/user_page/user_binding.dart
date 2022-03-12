import 'package:get/get.dart';

import 'user_logic.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLogic());
  }
}
