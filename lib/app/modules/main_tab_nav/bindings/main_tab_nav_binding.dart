import 'package:get/get.dart';

import '../controllers/main_tab_nav_controller.dart';

class MainTabNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabNavController>(
      () => MainTabNavController(),
    );
  }
}
