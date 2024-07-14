import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultNotice extends StatefulWidget {
  final Color color;
  final String text;
  const ResultNotice({super.key, required this.color, required this.text});

  @override
  State<StatefulWidget> createState() => _ResultNoticeState();
}

class _ResultNoticeState extends State<ResultNotice> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _fontSizeAnimation;

  @override
  void initState() {
    //创建动画控制器，执行时长200毫秒
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fontSizeAnimation = Tween<double>(begin: 12.0, end: 54.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ResultNotice oldWidget) {
    controller.forward(from: 0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: widget.color,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Text(
              widget.text,
              style: TextStyle(
                //字体大小(0~45变化)
                //fontSize: 54 * (controller.value),
                //字体大小(12~45变化)
                fontSize: _fontSizeAnimation.value,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}
