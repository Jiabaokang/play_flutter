import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:play_flutter/model/structure_model/wechat_public_model.dart';
import 'package:play_flutter/pages/user_page/page/head_circle_widget.dart';
import 'package:play_flutter/res/assets_res.dart';
import 'package:play_flutter/res_custom/image_list.dart';
import 'package:play_flutter/res_custom/shadow_style.dart';
import 'package:play_flutter/res_custom/style.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/10 16:42
/// desc   : 首页 微信公众号Item
class WechatPublicItem extends StatelessWidget {
  final WechatPublic item;

  const WechatPublicItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        decoration: ShadowStyle.white12Circle(radius: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: ShadowStyle.black12Circle40(),
              child: ImageList.wechatPublic.containsKey(item.id)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 64,
                        height: 64,
                        color: Colors.white,
                        child: Image.asset(ImageList.wechatPublic[item.id] ?? ""),
                      ),
                    )
                  : HeadCircleWidget(
                      width: 64,
                      height: 64,
                    ),
            ),
            Box.vBox15,
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsRes.WECHAT,
                  width: 20,
                ),
                Box.hBox3,
                Text(
                  item.name,
                  style: Styles.style_black_14,
                ),
              ],
            )
          ],
        ));
  }
}
