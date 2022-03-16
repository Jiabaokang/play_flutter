import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:play_flutter/pages/home_page/secondary_page/ask_page/ask_view.dart';
import 'package:play_flutter/pages/home_page/secondary_page/child_first_page/home_first_view.dart';
import 'package:play_flutter/pages/home_page/secondary_page/square_page/square_view.dart';
import 'package:play_flutter/res/colors.dart';
import 'package:play_flutter/res/r.dart';
import 'package:play_flutter/res/strings.dart';
import 'package:play_flutter/res/style.dart';
import 'package:play_flutter/widget/ripple_widget.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 09:36
/// desc   : 包含3个子页面的首页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    isScrollable: true,
                    controller: tabController,
                    tabs: [
                      Tab(text: StringStyles.tabHome.tr),
                      Tab(text: StringStyles.tabSquare.tr),
                      Tab(text: StringStyles.tabAsk.tr),
                    ],
                    labelColor: ColorStyle.color_24CF5F,
                    unselectedLabelColor: ColorStyle.color_B8C0D4,
                    labelStyle: Styles.style_FE8C28_24_bold,
                    unselectedLabelStyle: Styles.style_FFAE2E_16,
                  ),
                ),
                const Expanded(child: SizedBox()),
                ///搜索按钮
                Ripple(child: Padding(padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    R.assetsImagesSearch,
                    color: Colors.black87,
                    width: 30),
                )),
                const SizedBox(width: 10)
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [HomeFirstPage(), SquarePage(), AskPage()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
