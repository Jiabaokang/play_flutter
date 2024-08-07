import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:play_flutter/02_timer/home_page/button_tools.dart';
import 'package:play_flutter/02_timer/home_page/stopwatch_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StopwatchType _state = StopwatchType.none;

  late Ticker _ticker;
  Duration _duration = Duration.zero;

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
    );
  }

  Widget buildRecordPanel() {
    return Expanded(
      child: Container(
          // color: Colors.yellow,
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

  void onReset() {
    setState(() {
      _duration = Duration.zero;
      _state = StopwatchType.none;
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

  void onRecorder() {}

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
    print(value);
  }
}
