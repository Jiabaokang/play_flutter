import 'package:flutter/material.dart';
import 'package:play_flutter/base/get/get_save_state_view.dart';
import 'package:play_flutter/pages/home_page/secondary_page/ask_page/ask_list_Item.dart';
import 'package:play_flutter/widget/pull_smart_refresher.dart';

import 'ask_logic.dart';

class AskPage extends GetSaveView<AskLogic> {

  const AskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: RefreshWidget<AskLogic>(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.projectList.length,
            itemBuilder: (context, index) => AskListItem(
              item: controller.projectList[index],
              //收藏结果
              onResult: (value) {
                controller.projectList[index].collect = value;
              },
            ),
          ),
        ),
      ),
    );
  }
}
