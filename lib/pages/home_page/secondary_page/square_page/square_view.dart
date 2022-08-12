import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';
import 'package:play_flutter/pages/home_page/secondary_page/square_page/square_article_item.dart';
import 'package:play_flutter/utils/web_util.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';
import 'package:play_flutter/widget/ripple_widget.dart';

import 'square_logic.dart';

class SquarePage extends GetSaveView<SquareLogic> {
  const SquarePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:RefreshWidget<SquareLogic>(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.projectList.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: Ripple(
                      onTab: () => {
                            WebUtil.toWebPage(controller.projectList[index],
                                onResult: (value) {
                              controller.projectList[index].collect = value;
                            })
                          },
                      child: SquareArticleItem(
                        item: controller.projectList[index],
                      )),
                );
              }),
        ),
    );
  }
}
