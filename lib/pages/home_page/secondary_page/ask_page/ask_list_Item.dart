import 'package:flutter/material.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/pages/user_page/page/head_circle_widget.dart';
import 'package:play_flutter/res_custom/colors.dart';
import 'package:play_flutter/res_custom/style.dart';
import 'package:play_flutter/utils/web_util.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/12 15:01
/// desc   : 问答列表Item
class AskListItem extends StatelessWidget {
  const AskListItem({
    Key? key,
    required this.item,
    this.onResult,
  }) : super(key: key);

  ///列表项数据
  final ProjectDetail item;

  ///收藏点击事件
  final Function(bool)? onResult;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => WebUtil.toWebPage(item, onResult: onResult),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white, border: Border(bottom: BorderSide(width: 0.5, color: ColorStyle.color_EFF1F8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.style_black_16_bold,
            ),
            Box.vBox10,
            Row(
              children: [
                HeadCircleWidget(
                  width: 22,
                  height: 22,
                  icon: Icons.flutter_dash,
                ),
                Box.hBox5,
                Text(
                  item.shareUser.isEmpty ? item.author : item.shareUser,
                  style: Styles.style_B8C0D4_13,
                ),
                Box.hBox15,
                Text(
                  item.niceDate,
                  style: Styles.style_B8C0D4_13,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
