import 'package:flutter/material.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/page/basics_canvas_page.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/page/paper_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Paper App',
      //home: BasicsCanvasPage(),
      home: PaperPage(),
    );
  }
}
