import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/routes/app_pages.dart';
import 'package:play_flutter/utils/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'config/services/global_config.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  await initServer();
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  //渲染界面
  //runApp(const MainApp());
  runApp(const MainApp());
}

Future<void> initServer() async {
  print("stared server ...");

  //初始化存储服务
  //await StorageManager.init();
  //初始化配置服务
  await Get.putAsync(() => GlobalConfigService().init());

  print("all server stared");
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: true,
        enableLog: true,
        logWriterCallback: Logger.write,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        unknownRoute: AppPages.unknownRoute,
        locale: Get.deviceLocale,
        localizationsDelegates: const [
          S.delegate,
          RefreshLocalizations.delegate, //下拉刷新
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
