import 'package:flutter/material.dart';

import 'guess_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: GuessPage(title: "猜数字"),
    );
  }
}
