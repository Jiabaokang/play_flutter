import 'package:flutter/cupertino.dart';

class AnimateText extends StatefulWidget {
  final String text;
  const AnimateText({super.key, required this.text});

  @override
  State<AnimateText> createState() => _FadTextState();
}

/// 透明度变化
class _FadTextState extends State<AnimateText> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;

  @override
  void initState() {
    controller = AnimationController(vsync: this)..duration = const Duration(milliseconds: 500);

    ///透明度的过度动画，1～0的渐变过程表示从可见变为不可见。
    opacity = Tween(begin: 1.0, end: 0.0).animate(controller);
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
    controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
