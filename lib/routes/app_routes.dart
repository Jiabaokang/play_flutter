import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:play_flutter/pages/login_page/login_view.dart';
import 'package:play_flutter/pages/user_page/user_binding.dart';
import '../pages/login_page/not_found_view.dart';
import '../pages/login_page/splash_view.dart';
import '../pages/main_page/main_view.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 10:18
/// desc   : 路由配置管理

abstract class AppRoutes{

  static const String splashPage = "/splashPage";

  static const String mainTabNav = '/mainTabNav';

  static const String loginPage = "/loginPage";

  static const String notFound = "/notFound";

  ///项目中第一个要显示的页面，启动页
  static const initial = splashPage;

  static final List<GetPage> routes = [
    //启动页面
    GetPage(name: splashPage, page: ()=> const SplashPage()),
    //主页面
    GetPage(name: mainTabNav, page:()=> MainTabNavPage()),
    // 白名单
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
      binding: UserBinding()
    ),
  ];


  ///无法找到路由的时候显示的界面
  static final unknownRoute = GetPage(
    name: notFound,
    page: () => NotfoundView(),
  );

}