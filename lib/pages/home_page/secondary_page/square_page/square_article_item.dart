import 'package:flutter/material.dart';
import 'package:play_flutter/model/project_model/project_model.dart';
import 'package:play_flutter/res_custom/decoration_style.dart';
import 'package:play_flutter/res_custom/style.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/11 17:03
/// desc   : 广场文章的列表项
class SquareArticleItem extends StatelessWidget {
  ///列表数据
  ProjectDetail item;

  SquareArticleItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
      // decoration: DecorationStyle.customize(Colors.orangeAccent, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Box.vBox10,
          Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Styles.style_black_16_bold),
          Box.vBox5,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: item.fresh,
                child: Container(
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: DecorationStyle.customize(Colors.redAccent, 3),
                  child: const Text('新', style: Styles.style_white_10),
                ),
              ),
              Box.hBox10,
              Text(item.shareUser.isEmpty ? item.author : item.shareUser, style: Styles.style_9F9EA6_11),
              Box.hBox10,
              Text(item.niceDate, style: Styles.style_9F9EA6_11)
            ],
          ),
          Box.vBox10,
          DividerStyle.divider1Half
        ],
      ),
    );
  }
}
