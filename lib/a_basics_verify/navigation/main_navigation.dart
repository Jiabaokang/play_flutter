import 'package:flutter/material.dart';
import 'package:play_flutter/a_basics_verify/navigation/app_navigation.dart';
import 'package:play_flutter/a_basics_verify/storage/db_storage/db_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbStorage.instance.open();
  runApp(MyApp());
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
