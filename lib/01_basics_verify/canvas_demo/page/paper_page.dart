import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/models/line.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/widgets/color_selector.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/widgets/confirm_dialog.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/widgets/paper_appbar.dart';
import 'package:play_flutter/01_basics_verify/canvas_demo/widgets/stork_width_selector.dart';

class PaperPage extends StatefulWidget {
  const PaperPage({super.key});

  @override
  State<PaperPage> createState() => _PaperState();
}

class _PaperState extends State<PaperPage> with AutomaticKeepAliveClientMixin {
  ///线的列表
  final List<Line> _lines = [];

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
    Colors.pink,
    Colors.grey,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.yellowAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
  ];

  ///支持的线头宽度
  final List<double> supportStrokeWidths = [1, 2, 4, 6, 8, 10];

  ///当前激活的颜色下标
  int _activeColorIndex = 0;

  ///当前激活的线头宽度下标
  int _activeStrokeWidthIndex = 0;

  List<Line> _historyLines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(
        onClear: _showClearDialog,
        onBack: _lines.isEmpty ? null : _back,
        onRevocation: _historyLines.isEmpty ? null : _revocation,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: PaperPainter(lines: _lines),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: ColorSelector(
                    supportColors: supportColors,
                    activeColorIndex: _activeColorIndex,
                    onSelect: _onSelectColor,
                  ),
                ),
                StorkWidthSelector(
                  supportStorkWidths: supportStrokeWidths,
                  activeIndex: _activeStrokeWidthIndex,
                  color: supportColors[_activeColorIndex],
                  onSelect: _onSelectStoreWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///撤销
  void _back() {
    if (_lines.isNotEmpty) {
      Line line = _lines.removeLast();
      _historyLines.add(line);
      setState(() {});
    }
  }

  ///反撤销
  void _revocation() {
    if (_historyLines.isNotEmpty) {
      Line line = _historyLines.removeLast();
      _lines.add(line);
      setState(() {});
    }
  }

  void _showClearDialog() {
    var msg = "您当前内容将被清空，是否确定删除？";
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ConfirmDialog(
          title: "内容清空提示",
          content: msg,
          confirmText: "确定",
          onConfirm: _onClear,
        );
      },
    );
  }

  void _onClear() {
    _historyLines.clear();
    _lines.clear();
    Navigator.of(context).pop();
    setState(() {});
  }

  ///手指按下后回调
  void _onPanStart(DragStartDetails details) {
    // 记录手指按下的位置做标点
    _historyLines.clear();
    _lines.add(Line(
      points: [details.localPosition],
      color: supportColors[_activeColorIndex],
      strokeWidth: supportStrokeWidths[_activeStrokeWidthIndex],
    ));
  }

  ///手指拖动回调
  void _onPanUpdate(DragUpdateDetails details) {
    Offset point = details.localPosition;
    double distance = (_lines.last.points.last - point).distance;

    /// 如果距离大于5，则认为需要绘制
    if (distance > 10) {
      _lines.last.points.add(details.localPosition);
      //刷新页面
      setState(() {});
    }
  }

  ///选择颜色的回调
  void _onSelectColor(int value) {
    if (value != _activeColorIndex) {
      setState(() {
        _activeColorIndex = value;
      });
    }
  }

  ///选择线宽的回调
  void _onSelectStoreWidth(int value) {
    if (value != _activeStrokeWidthIndex) {
      setState(() {
        _activeStrokeWidthIndex = value;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
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
