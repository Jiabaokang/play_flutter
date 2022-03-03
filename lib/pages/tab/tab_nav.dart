import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/pages/tab/project_page.dart';
import 'package:play_flutter/pages/tab/structure_page.dart';
import 'package:play_flutter/pages/tab/user_page.dart';
import 'package:play_flutter/pages/tab/wechat_account_page.dart';
import '../../generated/l10n.dart';
import 'home_page.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 19:59
/// desc   : 首页导航

class TabNavigator extends StatelessWidget {
  TabNavigator({Key? key}) : super(key: key);

  final List<Widget> pages = <Widget>[
    HomePage(),
    ProjectPage(),
    WechatAccountPage(),
    StructurePage(),
    UserPage()
  ];

  //页面滑动控制器
  final PageController _pageController = PageController();

  //记录最后的点击事件
  DateTime? _lastTime;

  //记录选中的下标
  final RxInt _selectedIndex = RxInt(0);

  //设置值
  void setValue(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastTime == null ||
              DateTime.now().difference(_lastTime!) >
                  const Duration(milliseconds: 2000)) {
            _lastTime = DateTime.now();
            //提示退出
            showToast("请再按一次，退出应用！",textPadding: const EdgeInsets.fromLTRB(20,10,20,10));
            return false;
          } else {
            return true;
          }
        },
        child: PageView.builder(
          itemBuilder: (cex, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          //physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setValue(index);
            //_selectedIndex = index as RxInt;
          },
        ),
      ),
      //底部导航需要和PageView联动
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _bottomNavigationBarItems(context),
          currentIndex: _selectedIndex.value,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }

  //底部tab选项
  List<BottomNavigationBarItem> _bottomNavigationBarItems(context) => [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: S.of(context).tabHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.format_list_bulleted),
          label: S.of(context).tabProject,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group_work),
          label: S.of(context).wechatAccount,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.call_split),
          label: S.of(context).tabStructure,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.insert_emoticon),
          label: S.of(context).tabUser,
        ),
      ];
}
