import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:play_flutter/config/Injection_init.dart';
import 'package:play_flutter/routes/app_routes.dart';
import 'package:play_flutter/utils/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'generated/l10n.dart';

void main() async {
  //初始化配置
  await Injection.init();
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  //渲染界面
  //runApp(const MainApp());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: true,
    enableLog: true,
    logWriterCallback: Logger.write,
    initialRoute: AppRoutes.initial,
    getPages: AppRoutes.routes,
    unknownRoute: AppRoutes.unknownRoute,
    locale: Get.deviceLocale,
    localizationsDelegates: const [
      S.delegate,
      RefreshLocalizations.delegate, //下拉刷新
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: S.delegate.supportedLocales,
  ));
}

// class MainApp extends StatelessWidget {
//   const MainApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return OKToast(
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: true,
//         enableLog: true,
//         logWriterCallback: Logger.write,
//         initialRoute: AppRoutes.initial,
//         getPages: AppRoutes.routes,
//         unknownRoute: AppRoutes.unknownRoute,
//         locale: Get.deviceLocale,
//         localizationsDelegates: const [
//           S.delegate,
//           RefreshLocalizations.delegate, //下拉刷新
//           GlobalCupertinoLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate
//         ],
//         supportedLocales: S.delegate.supportedLocales,
//       ),
//     );
//   }
// }
