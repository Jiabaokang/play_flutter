import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:play_flutter/pages/login_page/login_view.dart';
import 'package:play_flutter/pages/main_page/main_binding.dart';
import 'package:play_flutter/pages/user_page/user_binding.dart';
import 'package:play_flutter/pages/webview_page/webview_binding.dart';
import 'package:play_flutter/pages/webview_page/webview_page.dart';
import '../pages/login_page/not_found_view.dart';
import '../pages/login_page/splash_view.dart';
import '../pages/main_page/main_view.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 10:18
/// desc   : 路由配置管理

abstract class AppRoutes {
  ///启动页
  static const String splashPage = "/splashPage";

  ///主页面切换
  static const String mainTabNav = '/mainTabNav';

  ///登录页面
  static const String loginPage = "/loginPage";

  ///webView
  static const String webViewPage = '/webView';

  ///无页面
  static const String notFound = "/notFound";

  ///积分排行榜
  static const String rankingPage = '/ranking';

  ///项目中第一个要显示的页面，启动页
  static const initial = splashPage;

  static final List<GetPage> routes = [
    //启动页面
    GetPage(name: splashPage, page: () => const SplashPage()),
    //主页面
    GetPage(name: mainTabNav, page: () => MainTabNavPage(), binding: MainBinding()),
    // 白名单
    GetPage(name: loginPage, page: () => const LoginPage(), binding: UserBinding()),
    //webView页面
    GetPage(name: webViewPage, page: () => const WebViewPage(), binding: WebViewBinding()),
  ];

  ///无法找到路由的时候显示的界面
  static final unknownRoute = GetPage(
    name: notFound,
    page: () => NotfoundView(),
  );
}
