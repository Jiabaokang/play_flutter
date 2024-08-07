import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/01_basics_verify/navigation/app_navigation.dart';
import 'package:play_flutter/01_basics_verify/storage/db_storage/db_storage.dart';

void main() async {
  //确保Flutter引擎已初始化
  WidgetsFlutterBinding.ensureInitialized();
  //初始化数据库
  DbStorage.instance.open();
  runApp(
    OKToast(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: AppNavigation(),
    );
  }
}
