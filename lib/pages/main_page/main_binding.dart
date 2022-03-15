import 'package:get/get.dart';
import 'package:play_flutter/pages/home_page/home_logic.dart';
import 'package:play_flutter/pages/home_page/secondary_page/ask_page/ask_logic.dart';
import 'package:play_flutter/pages/home_page/secondary_page/child_first_page/home_first_logic.dart';
import 'package:play_flutter/pages/home_page/secondary_page/square_page/square_logic.dart';
import 'package:play_flutter/pages/main_page/main_logic.dart';
import 'package:play_flutter/pages/official_account_page/official_account_logic.dart';
import 'package:play_flutter/pages/project_page/project_logic.dart';
import 'package:play_flutter/pages/structure_page/structure_logic.dart';



/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 09:36
/// desc   : 主页面binding层
class MainBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MainLogic());

    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => HomeFirstLogic());
    Get.lazyPut(() => SquareLogic());
    Get.lazyPut(() => AskLogic());

    //
    Get.lazyPut(() => ProjectLogic());
    Get.lazyPut(() => OfficialAccountLogic());
    Get.lazyPut(() => StructureLogic());
  }
}
