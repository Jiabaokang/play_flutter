import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/res/colors.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/15 18:19
/// desc   : 点击有水波纹的效果

class Ripple extends StatelessWidget {
  ///点击事件回调
  GestureTapCallback? onTab;

  /// 圆角大小
  double circular;

  /// 子Widget
  Widget child;

  Ripple({
    Key? key,
    this.onTab,
    this.circular = .0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(circular)),
      highlightColor: ColorStyle.color_E2E3E8_66,
      splashColor: ColorStyle.color_E2E3E8_66,
      onTap: onTab,
      child: child,
    );
  }
}
