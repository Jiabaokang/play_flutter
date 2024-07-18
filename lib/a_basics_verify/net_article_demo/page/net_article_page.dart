import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:play_flutter/a_basics_verify/net_article_demo/page/article_content.dart';

class NetArticlePage extends StatefulWidget {
  const NetArticlePage({super.key});

  @override
  State<StatefulWidget> createState() => _NetArticlePageState();
}

class _NetArticlePageState extends State<NetArticlePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //修改状态栏颜色
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.blue,
          ),

          title: const Text(
            "网络文章",
            style: TextStyle(fontSize: 18.0),
          ),
          centerTitle: true,
        ),
        body: const ArticleContent());
  }

  @override
  bool get wantKeepAlive => true;
}

// class NetArticlePage extends StatelessWidget {
//   const NetArticlePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarIconBrightness: Brightness.dark,
//           statusBarColor: Colors.transparent,
//         ),
//         title: const Text(
//           "网络文章",
//           style: TextStyle(fontSize: 18.0),
//         ),
//         centerTitle: true,
//       ),
//       body: const ArticleContent(),
//     );
//   }
// }
