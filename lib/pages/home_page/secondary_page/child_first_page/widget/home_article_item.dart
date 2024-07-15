import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/res_custom/decoration_style.dart';
import 'package:play_flutter/res_custom/style.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/10 10:33
/// desc   : 项目列表项组件
///
class FirstArticleItem extends StatelessWidget {
  ProjectDetail item;

  int index = 0;

  FirstArticleItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Box.vBox10,
          Stack(
            children: [
              Text(
                getPaddingText(item.title),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.style_black_16_bold,
              ),
              Visibility(
                  visible: index <= 2,
                  child: Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: DecorationStyle.customize(Colors.redAccent, 3),
                    child: const Text("荐", style: Styles.style_white_10),
                  ))
            ],
          ),
          Visibility(visible: item.desc.isNotEmpty, child: Html(data: item.desc)),
          Box.vBox10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.superChapterName,
                style: Styles.style_FE8C28_11,
              ),
              Box.hBox10,
              const Text("|", style: Styles.style_9F9EA6_11),
              Box.hBox10,
              Text(item.shareUser.isEmpty ? item.author : item.shareUser, style: Styles.style_9F9EA6_11),
              Box.hBox10,
              Text(item.niceDate, style: Styles.style_9F9EA6_11),
            ],
          ),
          Box.vBox10,
          DividerStyle.divider1Half
        ],
      ),
    );
  }

  ///留出空位显示 "荐" 字
  String getPaddingText(String title) {
    return index <= 2 ? "     $title" : title;
  }
}
