import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/a_basics_verify/canvas_demo/models/line.dart';
import 'package:play_flutter/a_basics_verify/canvas_demo/widgets/paper_appbar.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<PaperPage> createState() => _PaperState();
}

class _PaperState extends State<PaperPage> {
  ///线的列表
  List<Line> _lines = [];

  ///支持的颜色
  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  ///支持的线头宽度
  final List<double> supportStrokeWidths = [1, 2, 4, 6, 8, 10];

  ///当前激活的颜色下标
  int _activeColorIndex = 0;

  ///当前激活的线头宽度下标
  int _activeStrokeWidthIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _onClear,
      ),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: CustomPaint(
          painter: PaperPainter(lines: _lines),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
          ),
        ),
      ),
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('title'),
          content: Text('dialogBody'),
          actions: <Widget>[
            TextButton(
              child: Text('buttonText'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _onClear() {}

  ///手指按下后回调
  void _onPanStart(DragStartDetails details) {
    // 记录手指按下的位置做标点
    _lines.add(Line(points: [details.localPosition]));
  }

  ///手指拖动回调
  void _onPanUpdate(DragUpdateDetails details) {
    _lines.last.points.add(details.localPosition);
    //刷新页面
    setState(() {});
  }
}

///画布
class PaperPainter extends CustomPainter {
  final List<Line> lines;
  late Paint _paint;
  PaperPainter({required this.lines}) {
    _paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
  }

  ///开始绘制
  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      _drawLine(canvas, line);
    }
  }

  ///绘制线
  void _drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
