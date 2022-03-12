import 'package:get/get.dart';
import 'package:play_flutter/config/services/global_config.dart';
import 'package:play_flutter/http/request_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/11 17:13
/// desc   : 初始化时进行全局依赖注入
///
class Injection{

  static Future<void> init() async{

    //初始化配置项
    //Get.putAsync(()=> SharedPreferences.getInstance());
    Get.lazyPut(() => SharedPreferences.getInstance());
    //将网络请求数据仓库进行注入
    Get.lazyPut(() => RequestRepository());

    await Get.putAsync(() => GlobalConfigService().init());
    // await Get.putAsync(() => StorageManager.init());
  }
}