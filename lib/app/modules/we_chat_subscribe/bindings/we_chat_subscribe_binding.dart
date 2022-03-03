import 'package:get/get.dart';
import '../controllers/we_chat_subscribe_controller.dart';

class WeChatSubscribeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeChatSubscribeController>(
      () => WeChatSubscribeController(),
    );
  }
}
