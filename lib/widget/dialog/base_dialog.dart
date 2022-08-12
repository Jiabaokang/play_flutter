import 'package:flutter/material.dart';
import 'package:play_flutter/widget/over_scroll_behavior.dart';

/// author : JiaBaoKang
/// e-mail : jiabaokangsy@gmail.com
/// date   : 2022/3/17 15:31
/// desc   : 通用的dialog
class BaseDialog extends StatefulWidget {
  ///子控件
  final Widget child;

  ///圆角
  final double shape;

  ///左右边距
  final double horizontal;

  const BaseDialog({
    Key? key,
    this.shape = 10,
    this.horizontal = 25,
    required this.child,
  }) : super(key: key);

  @override
  State<BaseDialog> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> with TickerProviderStateMixin {
  ///动画控制
  late AnimationController scaleController;

  ///动画曲线
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 360));

    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: scaleController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    scaleController.forward();
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: ScrollConfiguration(
          ///去掉滚动的回弹效果
          behavior: OverScrollBehavior(),
          child: ScaleTransition(
            scale: scaleController,
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: [
                ///背景及内容必须包裹在ListView中
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(widget.shape))),
                  ),
                  child: widget.child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scaleController.dispose();
  }
}
