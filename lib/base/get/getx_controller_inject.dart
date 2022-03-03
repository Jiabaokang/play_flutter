import 'package:get/get.dart';
import 'package:play_flutter/http/request_repository.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/3 10:54
/// desc   : 基类 Controller
class BaseGetController extends GetxController{

  ///获取put进去的request
  late RequestRepository request;

  @override
  void onInit() {
    super.onInit();
    request = Get.find<RequestRepository>();
  }

}