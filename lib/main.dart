import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/config/Injection_init.dart';
import 'package:play_flutter/pages/login_page/splash_view.dart';
import 'package:play_flutter/res_custom/strings.dart';
import 'package:play_flutter/routes/app_routes.dart';
import 'package:play_flutter/utils/locale_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化配置
  await Injection.init();

  /// Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark));

  /// 渲染界面
  runApp(OKToast(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: true,

      ///路由管理
      getPages: AppRoutes.routes,

      ///第一个页面启动页面
      //initialRoute: AppRoutes.initial,
      ///查找路由失败提示界面
      unknownRoute: AppRoutes.unknownRoute,

      ///国际化-数据来源
      translations: Messages(),

      ///默认语言
      locale: LocaleOptions.getDefault(),

      ///国际化支持-备用语言
      fallbackLocale: const Locale('en', 'US'),

      ///默认动画
      defaultTransition: Transition.fade,
      home: const SplashPage(),
    ),
  ));
}
