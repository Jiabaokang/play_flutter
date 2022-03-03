
import 'package:get/get.dart';
import 'package:play_flutter/pages/tab/home_page.dart';
import 'package:play_flutter/pages/login/login.dart';
import 'package:play_flutter/pages/login/not_found.dart';
import 'package:play_flutter/pages/login/splash.dart';

import '../pages/tab/controller.dart';
import '../pages/tab/tab_nav.dart';
part 'app_routes.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 10:29
/// desc   : 所有的路由配置对应关系页面配置
///

abstract class AppPages{

  ///项目中第一个要显示的页面，启动页
  static const INITIAL = AppRoutes.Splash;

  static final List<GetPage> routes = [
    //启动页面
    GetPage(name: AppRoutes.Splash, page: ()=> const SplashPage()),
    //主页面
    GetPage(name: AppRoutes.Tabnav, page:()=> TabNavigator()),
    // 白名单
    GetPage(
      name: AppRoutes.Login,
      page: () => const LoginView(),
    ),
  ];



  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => NotfoundView(),
  );

}