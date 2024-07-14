import 'package:flutter/material.dart';
import 'package:play_flutter/a_basics_verify/muyu/muyu_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: MuYuPage(),
    );
  }
}
