import 'package:flutter/material.dart';
import 'package:play_flutter/01_basics_verify/net_article_demo/page/net_article_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: NetArticlePage(),
    );
  }
}
