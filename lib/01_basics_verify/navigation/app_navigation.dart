import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/page/paper_page.dart';
import 'package:play_flutter/01_basics_verify/guess_demo/guess_page.dart';
import 'package:play_flutter/01_basics_verify/muyu_demo/page/muyu_page.dart';
import 'package:play_flutter/01_basics_verify/navigation/app_bottom_bar.dart';
import 'package:play_flutter/01_basics_verify/net_article_demo/page/article_content.dart';
import 'package:play_flutter/01_basics_verify/net_article_demo/page/net_article_page.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _curIndex = 0;
  final PageController _pageController = PageController();

  final List<MenuData> menus = [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
    MenuData(label: '网络文章', icon: Icons.article),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      bottomNavigationBar: AppBottomBar(
        menus: menus,
        currentIndex: _curIndex,
        onItemTap: _onItemTap,
      ),
    );
  }

  ///底部导航栏点击回调
  void _onItemTap(index) {
    _pageController.jumpToPage(index);
    setState(() {
      _curIndex = index;
    });
  }

  ///页面切换回调
  void _onPageChanged(index) {
    setState(() {
      _curIndex = index;
    });
  }

  /// 构建主体部分
  Widget _buildContent() {
    return PageView(
      // 禁止滑动
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: _onPageChanged,
      children: const [GuessPage(), MuYuPage(), PaperPage(), NetArticlePage()],
    );
  }
}
