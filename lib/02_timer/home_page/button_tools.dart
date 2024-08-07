import 'package:flutter/material.dart';

enum StopwatchType {
  none, //初始状态
  stopped, //停止
  running //运行
}

class ButtonTools extends StatelessWidget {
  const ButtonTools({super.key, required this.state, this.onReset, this.onRecorder, this.toggle});

  final StopwatchType state;
  final VoidCallback? onReset;
  final VoidCallback? onRecorder;
  final VoidCallback? toggle;

  @override
  Widget build(BuildContext context) {
    bool running = state == StopwatchType.running;
    bool stopped = state == StopwatchType.stopped;
    Color activeColor = const Color(0xff3A3A3A);
    Color inactiveColor = const Color(0xffBDBDBD);
    Color resetColor = stopped ? activeColor : inactiveColor;
    Color flagColor = running ? activeColor : inactiveColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        spacing: 80,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (state != StopwatchType.none)
            InkWell(
              child: Icon(Icons.refresh, size: 28, color: resetColor),
              onTap: stopped ? onReset : null,
            ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            shape: const CircleBorder(side: BorderSide(color: Colors.green, width: 2.5)),
            child: running ? const Icon(Icons.stop, size: 28, color: Colors.white) : const Icon(Icons.play_arrow),
            onPressed: toggle,
          ),
          if (state != StopwatchType.none)
            GestureDetector(
              child: Icon(Icons.flag_outlined, size: 28, color: flagColor),
              onTap: running ? onRecorder : null,
            ),
        ],
      ),
    );
  }
}
