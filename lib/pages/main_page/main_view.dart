import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/pages/home_page/home_view.dart';
import 'package:play_flutter/pages/official_account_page/official_account_view.dart';
import 'package:play_flutter/pages/project_page/project_view.dart';
import 'package:play_flutter/pages/structure_page/structure_view.dart';
import 'package:play_flutter/pages/user_page/user_view.dart';
import 'package:play_flutter/res_custom/strings.dart';
import 'main_logic.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/2/23 19:59
/// desc   : 首页导航

class MainTabNavPage extends StatelessWidget {
  MainTabNavPage({Key? key}) : super(key: key);

  final logic = Get.put(MainLogic());

  final List<Widget> pages = <Widget>[
    HomePage(),
    ProjectPage(),
    OfficialAccountPage(),
    const StructurePage(),
    UserPage()
  ];

  //页面滑动控制器
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (logic.lastTime == null ||
              DateTime.now().difference(logic.lastTime!) > const Duration(milliseconds: 2000)) {
            logic.lastTime = DateTime.now();
            //提示退出
            showToast("请再按一次，退出应用！", textPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10));
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
            logic.currentIndex.value = index;
          },
        ),
      ),
      //底部导航需要和PageView联动
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _bottomNavigationBarItems(context),
          currentIndex: logic.currentIndex.value,
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
          label: StringStyles.homeComplex.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.format_list_bulleted),
          label: StringStyles.tabProject.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group_work),
          label: StringStyles.wechatAccount.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.call_split),
          label: StringStyles.tabStructure.tr,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.insert_emoticon),
          label: StringStyles.tabUser.tr,
        ),
      ];
}
