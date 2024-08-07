import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/widgets/paper_appbar.dart';

///绘画的基本认识
class BasicsCanvasPage extends StatefulWidget {
  const BasicsCanvasPage({super.key});

  @override
  State<BasicsCanvasPage> createState() => _BasicsCanvasPageState();
}

class _BasicsCanvasPageState extends State<BasicsCanvasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _onClear,
      ),
      body: CustomPaint(
        painter: PaperPainter(),

        ///希望画布的尺寸填充剩余空间，将 child 指定为 ConstrainedBox ，并通过 BoxConstraints.expand() 的约束
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
        ),
      ),
    );
  }

  void _onClear() {}
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 6
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round;

    ///画圆
    canvas.drawCircle(const Offset(100, 100), 50, paint);

    ///空心圆
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(const Offset(250, 100), 50, paint);

    ///画矩形
    Rect rect = Rect.fromCenter(center: const Offset(100, 200), width: 100, height: 80);
    canvas.drawRect(rect, paint);

    ///画圆角矩形
    //RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(8));
    //canvas.drawRRect(rRect, paint);
    RRect rRect = RRect.fromRectXY(rect.translate(150, 0), 8, 8);
    canvas.drawRRect(rRect, paint);

    ///drawOval 绘制椭圆：两个入参分别是矩形 Rect、画笔 Paint。
    Rect ovalRect = Rect.fromCenter(center: const Offset(100, 300), width: 100, height: 80);
    canvas.drawOval(ovalRect, paint);

    /// drawArc 绘制圆弧：五个入参分别是矩形 RRect、起始弧度 double、扫描弧度 double、是否闭合 bool、画笔 Paint。
    Rect arcRect = ovalRect.translate(150, 0);
    canvas.drawArc(arcRect, 0, pi * 1.25, true, paint);

    List<Offset> points = const [
      Offset(100, 400),
      Offset(100, 500),
      Offset(150, 500),
      Offset(200, 400),
    ];

    ///画点
    //canvas.drawPoints(PointMode.points, points, paint);
    ///画线
    canvas.drawPoints(PointMode.lines, points, paint);

    ///画多边形
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
