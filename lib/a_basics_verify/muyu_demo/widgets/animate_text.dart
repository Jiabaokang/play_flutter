import 'package:flutter/cupertino.dart';
import 'package:play_flutter/a_basics_verify/muyu_demo/models/merit_record.dart';

class AnimateText extends StatefulWidget {
  final String text;
  final MeritRecord record;
  const AnimateText({super.key, required this.text, required this.record});

  @override
  State<AnimateText> createState() => _FadTextState();
}

/// 透明度变化
class _FadTextState extends State<AnimateText> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> position;
  late Animation<double> scale;

  @override
  void initState() {
    controller = AnimationController(vsync: this)..duration = const Duration(milliseconds: 500);

    ///透明度的过度动画，1～0的渐变过程表示从可见变为不可见。
    opacity = Tween(begin: 1.0, end: 0.0).animate(controller);

    ///位置过度动画
    position = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(controller);

    ///缩放过度动画
    scale = Tween(begin: 1.0, end: 0.0).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimateText oldWidget) {
    super.didUpdateWidget(oldWidget);

    ///解决切换木鱼图片会显示一次功德的bug
    if (oldWidget.record.id != widget.record.id) {
      controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: SlideTransition(
        position: position,
        child: FadeTransition(
          opacity: opacity,
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
