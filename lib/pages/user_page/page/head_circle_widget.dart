import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:play_flutter/res/assets_res.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/8/10 14:51
/// desc   : 圆角头像处理框
class HeadCircleWidget extends StatelessWidget {
  double width = 60;
  double height = 60;

  IconData? icon;

  HeadCircleWidget({Key? key, this.width = 60, this.height = 60, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: SvgPicture.asset(
          AssetsRes.USER_HEADER_DEFAULT_ICON,
        ),
      ),
    );
  }
}
