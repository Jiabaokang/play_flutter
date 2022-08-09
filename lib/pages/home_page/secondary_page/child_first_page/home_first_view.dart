import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';
import 'package:play_flutter/pages/home_page/secondary_page/child_first_page/widget/banner_widget.dart';
import 'package:play_flutter/pages/home_page/secondary_page/child_first_page/widget/wechat_public_widget.dart';
import 'package:play_flutter/routes/app_routes.dart';
import 'package:play_flutter/utils/web_util.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'home_first_logic.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 23:20
/// desc   : 首页
class HomeFirstPage extends GetSaveView<HomeFirstLogic> {
  const HomeFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //列表项数量
    var _itemCount = (controller.projectData.length + 1) +
        (controller.insertIndex == -1 ? 0 : 1);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: RefreshWidget<HomeFirstLogic>(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      //列表的数量
                      itemCount: _itemCount,
                      //构建列表
                      itemBuilder: (context, index) {
                        /// 加载顶部Banner数据
                        if (index == 0) {
                          return Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            width: double.infinity,
                            height: 140,
                            child: BannerWidget(
                                bannerList: controller.bannerList,
                                height: 140,
                                onTab: (index) {
                                  if(index == 0){
                                    Get.toNamed(AppRoutes.rankingPage);
                                  }else{
                                    WebUtil.toWebPageBanners(controller.bannerList[index]);
                                  }
                                }),
                            //child: BannerW,
                          );
                        }
                        /// 随机出现公众号列表
                        else if(index == controller.insertIndex){
                          //TODO 完成列表开发
                            return Obx(()=>WechatPublicWidget());
                        }
                        /// 计算列表数据的真实下标(显示项目数据)
                        else {
                          return Text("data");
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

