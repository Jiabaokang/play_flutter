import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:play_flutter/pages/home_page/home_view.dart';
import 'package:play_flutter/pages/official_account_page/official_account_view.dart';
import 'package:play_flutter/pages/project_page/project_view.dart';
import 'package:play_flutter/pages/structure_page/structure_view.dart';
import 'package:play_flutter/pages/user_page/user_view.dart';
import 'package:play_flutter/res_custom/strings.dart';
import 'package:play_flutter/routes/app_routes.dart';
import 'package:play_flutter/widget/dialog/dialog_common_style.dart';
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
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showBackDialog(context) ?? false;
          if (context.mounted && shouldPop) {
            //退出应用
            SystemNavigator.pop(animated: true);
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

  Future<bool?> _showBackDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('确定退出应用吗?'),
          content: const Text('您确定要离开此页面吗?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('取消'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('确定'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}
