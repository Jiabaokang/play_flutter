import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:play_flutter/02_timer/home_page/button_tools.dart';
import 'package:play_flutter/02_timer/home_page/model/time_record.dart';
import 'package:play_flutter/02_timer/home_page/record_panel.dart';
import 'package:play_flutter/02_timer/home_page/stopwatch_widget.dart';
import 'package:play_flutter/02_timer/setting_page/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StopwatchType _state = StopwatchType.none;

  late Ticker _ticker;
  Duration _duration = Duration.zero;
  Duration _secondDuration = Duration.zero;

  List<TimeRecord> _records = [];

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick);
  }

  Duration dt = Duration.zero;
  Duration lastDuration = Duration.zero;

  void _onTick(Duration elapsed) {
    setState(() {
      dt = elapsed - lastDuration;
      _duration = _duration + dt;
      lastDuration = elapsed;

      if (_records.isNotEmpty) {
        _secondDuration = _duration - _records.last.record;
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('计时器'),
        backgroundColor: Colors.white,
        actions: _buildActions(),
      ),
      body: Column(children: [
        buildStopwatchPanel(),
        buildRecordPanel(),
        buildTools(_state),
      ]),
    );
  }

  Widget buildStopwatchPanel() {
    double radius = MediaQuery.of(context).size.shortestSide / 2 * 0.75;
    //Duration duration = const Duration(minutes: 3, seconds: 28, milliseconds: 50);
    return StopwatchWidget(
      radius: radius,
      duration: _duration,
      secondDuration: _secondDuration,
    );
  }

  Widget buildRecordPanel() {
    return Expanded(
      child: RecordPanel(
        records: _records,
      ),
    );
  }

  Widget buildTools(StopwatchType state) {
    return ButtonTools(
      state: state,
      onReset: onReset,
      onRecorder: onRecorder,
      toggle: toggle,
    );
  }

  /// 重置秒表
  void onReset() {
    setState(() {
      _duration = Duration.zero;
      _secondDuration = Duration.zero;
      _state = StopwatchType.none;
      _records.clear();
    });
  }

  /// 切换秒表状态
  void toggle() {
    bool running = _state == StopwatchType.running;
    if (running) {
      _ticker.stop();
      lastDuration = Duration.zero;
    } else {
      _ticker.start();
    }
    setState(() {
      _state = running ? StopwatchType.stopped : StopwatchType.running;
    });
  }

  /// 添加记录
  void onRecorder() {
    Duration current = _duration;
    Duration addition = _duration;

    if (_records.isNotEmpty) {
      addition = _duration - _records.last.record;
    }

    // 添加记录，刷新界面
    setState(() {
      _records.add(TimeRecord(record: current, addition: addition));
    });
  }

  List<Widget> _buildActions() {
    return [
      PopupMenuButton<String>(
        itemBuilder: _buildItem,
        onSelected: _onSelectedItem,
        icon: const Icon(Icons.more_vert, color: Colors.black),
        position: PopupMenuPosition.under,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      )
    ];
  }

  List<PopupMenuEntry<String>> _buildItem(BuildContext context) {
    return [
      const PopupMenuItem<String>(
        height: 35,
        value: '设置',
        child: Center(
          child: Text('设置', style: TextStyle(fontSize: 14)),
        ),
      ),
      const PopupMenuItem<String>(
        height: 35,
        value: '退出',
        child: Center(
          child: Text('退出', style: TextStyle(fontSize: 14)),
        ),
      )
    ];
  }

  void _onSelectedItem(String value) {
    if (value == '设置') {
      //默认跳转
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (cex) => const SettingPage(),
      //   ),
      // );
      // 自定义右到作的跳转动画
      Navigator.of(context).push(
        RightToLeftRouter(child: const SettingPage()),
      );
    }
  }
}

/// 路由动画
class RightToLeftRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int durationMs;
  final Curve curve;

  RightToLeftRouter({required this.child, this.durationMs = 200, this.curve = Curves.fastOutSlowIn})
      : super(
          transitionDuration: Duration(milliseconds: durationMs),
          pageBuilder: (ctx, animation, secondaryAnimation) => child,
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) => SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(CurvedAnimation(parent: animation, curve: curve)),
          ),
        );
}
