import 'dart:math'; // 引入数学库，提供数学常数和函数
import 'package:flutter/material.dart'; // 引入Flutter的Material包
import 'package:play_flutter/res/font_res.dart'; // 引入字体资源包

// 定义一个无状态的秒表组件
class StopwatchWidget extends StatelessWidget {
  final double radius; // 圆形秒表的半径
  final Duration duration; // 秒表的持续时间
  final Color? themeColor; // 秒表主题颜色
  final TextStyle? textStyle; // 文本样式
  final Color scaleColor; // 刻度颜色

// 构造函数
  const StopwatchWidget({
    super.key,
    required this.radius, // 必需参数，秒表半径
    required this.duration, // 必需参数，持续时间
    this.scaleColor = Colors.black26, // 可选参数，默认为黑色26%透明度
    this.themeColor, // 可选参数，主题颜色
    this.textStyle, // 可选参数，文本样式
  });

// 获取通用文本样式
  TextStyle get commonTextStyle => TextStyle(
        fontSize: radius / 3.2, // 根据半径计算字体大小
        fontWeight: FontWeight.bold, // 字体加粗
        fontFamily: FontRes.ICONFONT, // 字体家族
        color: Colors.black38, // 字体颜色
      );

// 构建Widget
  @override
  Widget build(BuildContext context) {
    final style = textStyle ?? commonTextStyle; // 获取文本样式
    final themeColor = this.themeColor ?? Theme.of(context).primaryColor; // 获取主题颜色
    return CustomPaint(
      painter: StopwatchPainter(
        radius: radius,
        // 传递半径
        duration: duration,
        // 传递持续时间
        themeColor: themeColor,
        // 传递主题颜色
        scaleColor: scaleColor,
        // 传递刻度颜色
        textStyle: style, // 传递文本样式
      ),
      size: Size(radius * 2, radius * 2), // 设置画布大小为直径
    );
  }
}

// 定义刻度比例常量
const double _kScaleWidthRate = 0.4 / 10;
const _kIndicatorRadiusRate = 0.2 / 10;
const _kStrokeWidthRate = 0.8 / 135.0;

// 自定义秒表画笔
class StopwatchPainter extends CustomPainter {
  final double radius; // 圆形秒表的半径
  final Duration duration; // 秒表的持续时间
  final Color themeColor; // 秒表主题颜色
  final TextStyle textStyle; // 文本样式
  final Color scaleColor; // 刻度颜色

// 构造函数
  StopwatchPainter({
    required this.radius, // 必需参数，秒表半径
    required this.duration, // 必需参数，持续时间
    required this.themeColor, // 必需参数，主题颜色
    required this.textStyle, // 必需参数，文本样式
    required this.scaleColor, // 必需参数，刻度颜色
  }) {
    scalePainter
      ..style = PaintingStyle.stroke // 设置绘画样式为描边
      ..strokeWidth = _kStrokeWidthRate * radius; // 设置描边宽度
    indicatorPainter.color = themeColor; // 设置指针颜色为主题颜色
  }

  final Paint scalePainter = Paint(); // 定义刻度画笔
  final Paint indicatorPainter = Paint(); // 定义指针画笔
  final TextPainter textPainter = TextPainter(
    // 定义文字画笔
    textAlign: TextAlign.center, // 文本对齐方式为居中
    textDirection: TextDirection.ltr, // 文本方向为从左到右
  );

  /// 绘制方法
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2); // 将画布移动到中心
    drawScale(canvas, size); // 绘制刻度

    final double scaleLineWidth = size.width * _kScaleWidthRate; // 计算刻度线宽度
    final double indicatorRadius = size.width * _kIndicatorRadiusRate; // 计算指针半径
    canvas.save(); // 保存画布状态

    int second = duration.inSeconds % 60; // 获取当前秒
    int milliseconds = duration.inMilliseconds % 1000; // 获取当前毫秒
    double radians = (second * 1000 + milliseconds) / (60 * 1000) * 2 * pi; // 计算旋转角度
    canvas.rotate(radians); // 旋转画布

    final radius = indicatorRadius / 2; // 计算指针半径的一半
    final point = Offset(0, -size.width / 2 + scaleLineWidth + indicatorRadius); // 计算指针位置
    canvas.drawCircle(point, radius, indicatorPainter); // 绘制圆形指针
    canvas.restore(); // 恢复画布状态
    drawText(canvas); // 绘制文字
  }

  /// 绘制文字方法
  void drawText(Canvas canvas) {
    int minus = duration.inMinutes % 60; // 获取当前分钟
    int second = duration.inSeconds % 60; // 获取当前秒
    int milliseconds = duration.inMilliseconds % 1000; // 获取当前毫秒
    String commonStr = '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}'; // 格式化分钟和秒
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}"; // 格式化毫秒
    textPainter.text = TextSpan(
        text: commonStr,
        style: textStyle,
        children: [TextSpan(text: highlightStr, style: textStyle.copyWith(color: themeColor))]); // 设置文本和样式
    textPainter.layout(); // 进行布局
    final double width = textPainter.size.width; // 获取文本宽度
    final double height = textPainter.size.height; // 获取文本高度
    textPainter.paint(canvas, Offset(-width / 2, -height / 2)); // 在画布上绘制文本
  }

  /// 绘制刻度方法
  void drawScale(Canvas canvas, Size size) {
    final scaleLineWidth = size.width * _kScaleWidthRate; // 计算刻度线宽度
    for (int i = 0; i < 180; i++) {
      if (i == 90 + 45) {
        scalePainter.color = themeColor; // 特殊刻度线颜色为主题颜色
      } else {
        scalePainter.color = scaleColor; // 普通刻度线颜色为刻度颜色
      }
      canvas.drawLine(
        Offset(size.width / 2, 0), // 起点
        Offset(size.width / 2 - scaleLineWidth, 0), // 终点
        scalePainter,
      );
      canvas.rotate(pi / 180 * 2); // 每次旋转2度
    }
  }

// 判断是否需要重新绘制
  @override
  bool shouldRepaint(covariant StopwatchPainter oldDelegate) {
    return oldDelegate.duration != duration || // 如果持续时间不同
        oldDelegate.textStyle != textStyle || // 如果文本样式不同
        oldDelegate.themeColor != themeColor || // 如果主题颜色不同
        oldDelegate.scaleColor != scaleColor; // 如果刻度颜色不同
  }
}
