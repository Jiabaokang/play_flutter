import 'package:get/get.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/17 15:14
/// desc   : Get的扩展方法
extension GetExtension on GetInterface{

  ///影藏dialog
  dismiss(){
    if(Get.isDialogOpen != null && Get.isDialogOpen!){
      Get.back();
    }
  }

  ///显示dialog
  showLoading({String text = ""}){
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }

  }

}